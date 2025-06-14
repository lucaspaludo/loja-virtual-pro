import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/models/product.dart';
import 'package:loja_virtual_pro/screens/edit_product/components/images_form.dart';
import 'package:loja_virtual_pro/screens/edit_product/components/sizes_form.dart';

class EditProductScreen extends StatelessWidget {
  final Product product;
  final bool editing;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  EditProductScreen(Product? p, {super.key})
      : editing = p != null,
        product = p?.clone() ?? Product.empty();

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(editing ? 'Editar Produto' : 'Criar Produto'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            ImagesForm(product),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    initialValue: product.name,
                    decoration: const InputDecoration(
                      hintText: 'Título',
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    validator: (name) {
                      if (name!.length < 6) return 'Título muito curto';
                      return null;
                    },
                    onSaved: (name) => product.name = name!,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'A partir de',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Text(
                    //'R\$ ${product.basePrice.toStringAsFixed(2)}',
                    '...',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Descrição',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  TextFormField(
                    initialValue: product.description,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Descrição',
                      border: InputBorder.none,
                    ),
                    maxLines: null,
                    validator: (desc) {
                      if (desc!.length < 10) return 'Descirção muito curta';
                      return null;
                    },
                    onSaved: (desc) => product.description = desc!,
                  ),
                  SizesForm(product),
                  SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(primaryColor),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState?.save();
                          product.save();
                        }
                      },
                      child: const Text(
                        'Salvar',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
