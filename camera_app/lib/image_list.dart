import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageList extends StatefulWidget {
  const ImageList({super.key});

  @override
  State<ImageList> createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  File? _selectedImage;

  Future<void> _selectImage(ImageSource source) async {
    final returnedImage =
        await ImagePicker().pickImage(source: source);

    if (returnedImage == null) return;
      
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Selector'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MaterialButton(
            onPressed: () => _selectImage(ImageSource.gallery),
            color: Colors.blue[200],
            child: const Text('Selecionar imagem'),
          ),
          MaterialButton(
            onPressed: () => _selectImage(ImageSource.camera),
            color: Colors.red[200],
            child: const Text('Selecionar imagem da camera'),
          ),
          _selectedImage == null
              ? const Expanded(
                  child: Center(
                    child: Text(
                      'Por favor, selecione uma imagem',
                      style: TextStyle(
                        fontSize: 20
                      ),
                    ),
                  ),
                )
              : Image.file(_selectedImage!),
        ],
      ),
    );
  }
}
