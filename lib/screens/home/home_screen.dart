import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/common/customDrawer/custom_drawer.dart';
import 'package:loja_virtual_pro/models/home_maneger.dart';
import 'package:loja_virtual_pro/models/user_manager.dart';
import 'package:loja_virtual_pro/screens/home/components/section_list.dart';
import 'package:loja_virtual_pro/screens/home/components/section_staggered.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 44, 123, 189),
                  Color.fromARGB(255, 94, 140, 192),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                snap: true,
                floating: true,
                //TODO: MUDAR BACKGROUND COLORS PARA TRANSPARENT
                backgroundColor: Colors.transparent,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text('Loja do Lucas'),
                  centerTitle: true,
                ),
                actions: <Widget>[
                  IconButton(
                    onPressed: () => Navigator.of(context).pushNamed('/cart'),
                    icon: const Icon(Icons.shopping_cart),
                  ),
                  Consumer2<UserManager, HomeManager>(
                      builder: (_, userManager, homeManager, __) {
                    if (userManager.adminEnabled) {
                      if (homeManager.editing) {
                        return PopupMenuButton(onSelected: (e) {
                          if (e == 'Salvar') {
                            homeManager.saveEditing();
                          } else {
                            homeManager.discardEditing();
                          }
                        }, itemBuilder: (_) {
                          return ['Salvar', 'Descartar'].map((e) {
                            return PopupMenuItem(value: e, child: Text(e));
                          }).toList();
                        });
                      } else {
                        return IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: homeManager.enterEditing,
                        );
                      }
                    } else {
                      return Container();
                    }
                  })
                ],
              ),
              Consumer<HomeManager>(
                builder: (_, homeManager, __) {
                  final List<Widget> children =
                      homeManager.sections.map<Widget>((section) {
                    switch (section.type) {
                      case "List":
                        return SectionList(section);

                      case "Staggered":
                        return SectionStaggered(section);

                      default:
                        return Container();
                    }
                  }).toList();
                  return SliverList(
                    delegate: SliverChildListDelegate(children),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
