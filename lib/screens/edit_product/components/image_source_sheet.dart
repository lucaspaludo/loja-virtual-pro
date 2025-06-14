import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  ImageSourceSheet({super.key, required this.onImageSelected});

  final Function(File) onImageSelected;

  final ImagePicker picker = ImagePicker();

  Future<void> editImage(String path, BuildContext context) async {
    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Editar Imagem',
          toolbarColor: Theme.of(context).primaryColor,
          toolbarWidgetColor: Colors.white,
        )
      ],
    );
    if (croppedFile != null) {
      onImageSelected(File(croppedFile.path));
    }
  }

  //TODO: Melhorar image crop

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ElevatedButton(
            onPressed: () async {
              final file = await picker.pickImage(source: ImageSource.camera);
              if (file == null) return;
              // ignore: use_build_context_synchronously
              editImage(file.path, context);
            },
            child: const Text('Câmera'),
          ),
          ElevatedButton(
            onPressed: () async {
              final file = await picker.pickImage(source: ImageSource.gallery);
              // ignore: use_build_context_synchronously
              editImage(file!.path, context);
            },
            child: const Text('Galeria'),
          ),
        ],
      ),
    );
  }
}
