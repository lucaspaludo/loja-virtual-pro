import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/models/product.dart';
import 'package:loja_virtual_pro/screens/edit_product/components/images_form.dart';

class EditProductScreen extends StatelessWidget {
  final Product product;
  const EditProductScreen(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Anúncio'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        children: <Widget>[
          ImagesForm(product),
        ],
      ),
    );
  }
}


