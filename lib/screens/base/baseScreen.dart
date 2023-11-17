import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/common/customDrawer/customDrawer.dart';
import 'package:loja_virtual_pro/screens/products/productsScreen.dart';
import 'package:provider/provider.dart';

import '../../models/pageManager.dart';
import '../login/loginScreen.dart';

class BaseScreen extends StatelessWidget {
  BaseScreen({super.key});
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Home1'),
              backgroundColor: primaryColor,
            ),
          ),
          const ProductsScreen(),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Home3'),
              backgroundColor: primaryColor,
            ),
          ),
          Container(
            color: Colors.red,
          ),
          Container(
            color: Colors.yellow,
          ),
          Container(
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
