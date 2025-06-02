import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/models/product.dart';
import 'package:loja_virtual_pro/screens/edit_product/components/image_source_sheet.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImagesForm extends StatefulWidget {
  final Product product;
  const ImagesForm(this.product, {super.key});

  @override
  _ImagesFormState createState() => _ImagesFormState();
}

class _ImagesFormState extends State<ImagesForm> {
  final controller = CarouselController();
  int currentIndex = 0; // Variável para armazenar o índice da imagem atual

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      initialValue: widget.product.images,
      validator: (images) {
        if (images!.isEmpty) return 'Insira ao menos uma imagem';
        return null;
      },
      builder: (state) {
        void onImageSelected(File file) {
          state.value!.add(file);
          state.didChange(state.value);
          Navigator.of(context).pop();
        }

        return Column(
          children: [
            CarouselSlider.builder(
              carouselController: controller,
              // Aumenta o itemCount para incluir o botão de câmera
              itemCount: state.value!.length + 1,
              itemBuilder: (context, index, realIndex) {
                // Verifica se é o último item para exibir o IconButton
                if (index == widget.product.images.length) {
                  return Container(
                    width: MediaQuery.of(context)
                        .size
                        .width, // Largura total da tela
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: IconButton(
                        icon: const Icon(
                          Icons.add_a_photo,
                          size: 50,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) => ImageSourceSheet(
                              onImageSelected: onImageSelected,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }

                // Caso contrário, exibe as imagens normalmente
                final image = widget.product.images[index];
                return Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context)
                          .size
                          .width, // Largura total da tela
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ), // Espaçamento entre as imagens
                      child: image is String
                          ? Image.network(
                              image,
                              fit: BoxFit.cover, // Ajuste da imagem à tela
                              width: double
                                  .infinity, // Garante que a imagem ocupe toda a largura
                            )
                          : Image.file(
                              image as File,
                              fit: BoxFit.cover, // Ajuste da imagem à tela
                              width: double
                                  .infinity, // Garante que a imagem ocupe toda a largura
                            ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () {
                          setState(() {
                            state.value!.remove(image);
                            widget.product.images.remove(image);
                            state.didChange(state.value);
                          });
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
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index; // Atualiza o índice atual
                  });
                },
              ),
            ),
            if (state.hasError)
              Container(
                margin: const EdgeInsets.only(top: 16, left: 16),
                alignment: Alignment.centerLeft,
                child: Text(
                  state.errorText ?? '',
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),

            const SizedBox(
              height: 16,
            ), // Espaçamento entre o carrossel e os pontinhos
            AnimatedSmoothIndicator(
              activeIndex: currentIndex,
              // Atualiza o contador para incluir o botão de câmera
              count: widget.product.images.length + 1,
              effect: const ScrollingDotsEffect(
                dotWidth: 10.0,
                dotHeight: 10.0,
                activeDotColor: Colors.blue,
              ),
            ),
          ],
        );
      },
    );
  }
}
