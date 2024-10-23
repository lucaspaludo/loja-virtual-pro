import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/common/customDrawer/custom_drawer.dart';
import 'package:loja_virtual_pro/models/admin_users_manager.dart';
import 'package:provider/provider.dart';

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Usuários'),
        centerTitle: true,
      ),
      body: Consumer<AdminUsersManager>(builder: (_, adminUsersManager, __) {
        return AlphabetListScrollView(
          itemBuilder: (_, index) {
            return ListTile(
              title: Text(adminUsersManager.users[index].name,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),),
              subtitle: Text(adminUsersManager.users[index].email,
              style: const TextStyle(
                color: Colors.white,
              ),),
            );
          },
          highlightTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          indexedHeight: (index) => 80,
          strList: adminUsersManager.names,
          showPreview: true,
        );
      },),
    );
  }
}
