import 'dart:io';

import 'package:camera/camera.dart';
import 'package:camera_app/home.dart';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.file(picture),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    Gal.putImage(widget.file.path);
                    Navigator.pop(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                  iconSize: 60,
                  icon: const Icon(Icons.check),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                  iconSize: 60,
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
