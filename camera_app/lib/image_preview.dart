import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ImagePreview extends StatefulWidget {
  final XFile file;

  const ImagePreview(this.file, {super.key});

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  @override
  Widget build(BuildContext context) {
    File picture = File(widget.file.path);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Preview'),
      ),
      body: Center(
        child: Image.file(picture),
      ),
    );
  }
}
