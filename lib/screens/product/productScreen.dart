import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:loja_virtual_pro/models/carManager.dart';
import 'package:loja_virtual_pro/models/userManager.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import 'components/sizeWidget.dart';

class ProductScreen extends StatelessWidget {
  final Product product;
  final controller = CarouselController();
  ProductScreen(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Text(
              product.name,
            ),
            centerTitle: true,
          ),
          backgroundColor: Colors.white,
          body: ListView(
            children: <Widget>[
              const Padding(padding: EdgeInsets.only(top: 10)),
              CarouselSlider.builder(
                carouselController: controller,
                itemCount: product.images.length,
                itemBuilder: (context, index, realIndex) {
                  final urlImage = product.images[index];
                  return buildImage(urlImage, index);
                },
                options: CarouselOptions(
                  autoPlay: false,
                  height: 350,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      product.name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'A partir de',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Text(
                      'R\$ 19.99',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 8),
                      child: Text(
                        'Descrição',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      product.description,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 8),
                      child: Text(
                        'Tamanhos',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: product.sizes.map((s) {
                        return SizeWidget(size: s);
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (product.hasStock)
                      Consumer2<UserManager, Product>(
                          builder: (_, userManager, product, __) {
                        return SizedBox(
                            height: 44,
                            child: ElevatedButton(
                              onPressed: product.selectedSize != null
                                  ? () {
                                      if (userManager.isLoggedIn) {
                                        context
                                            .read<CartManager>()
                                            .addToCart(product);
                                      } else {
                                        Navigator.of(context)
                                            .pushNamed('/login');
                                      }
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                              ),
                              child: Text(
                                userManager.isLoggedIn
                                    ? 'Adicionar ao carrinho'
                                    : 'Entre para Comprar',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ));
                      }),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

Widget buildImage(String urlImage, int index) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 5),
    child: Image.network(
      urlImage,
      fit: BoxFit.cover,
    ),
  );
}
