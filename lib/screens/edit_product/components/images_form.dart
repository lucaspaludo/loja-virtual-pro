import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/models/product.dart';

class ImagesForm extends StatelessWidget {
  ImagesForm(this.product, {super.key});
  final controller = CarouselController();

  final Product product;

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      initialValue: product.images,
      builder: (state) {
        return CarouselSlider.builder(
          carouselController: controller,
          itemCount: product.images.length,
          itemBuilder: (context, index, realIndex) {
            final image = state.value![index];
            return Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width, // Largura total da tela
                  margin: const EdgeInsets.symmetric(horizontal: 10), // Espaçamento entre as imagens
                  child: image is String
                      ? Image.network(
                          image,
                          fit: BoxFit.cover, // Ajuste da imagem à tela
                          width: double.infinity, // Garante que a imagem ocupe toda a largura
                        )
                      : Image.file(
                          image as File,
                          fit: BoxFit.cover, // Ajuste da imagem à tela
                          width: double.infinity, // Garante que a imagem ocupe toda a largura
                        ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.remove),
                    color: Colors.red,
                    onPressed: () {
                      // lógica de remover imagem
                    },
                  ),
                )
              ],
            );
          },
          options: CarouselOptions(
            height: 350,
            enlargeCenterPage: true, // Aumenta a imagem central
            viewportFraction: 1.0, // Cada item ocupa toda a largura da tela
          ),
        );
      },
    );
  }
}
