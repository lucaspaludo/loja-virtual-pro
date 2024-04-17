import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/common/customDrawer/custom_drawer.dart';
import 'package:loja_virtual_pro/models/page_manager.dart';
import 'package:loja_virtual_pro/screens/home/home_screen.dart';
import 'package:loja_virtual_pro/screens/products/products_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  BaseScreen({super.key});
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_final_locals
    Color primaryColor = Theme.of(context).primaryColor;
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          const HomeScreen(),
          const ProductsScreen(),
          Scaffold(
            drawer: const CustomDrawer(),
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
