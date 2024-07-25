import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ImagePreview extends StatefulWidget {
  final XFile file;

  const ImagePreview(this.file, {super.key});

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  Future<void> _savePicture(XFile picture) async {
    Directory directory = await getApplicationDocumentsDirectory();
    File file = File(path.join(directory.path, path.basename(picture.path)));
    await picture.saveTo(directory.path);
  }

  @override
  Widget build(BuildContext context) {
    File picture = File(widget.file.path);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Preview'),
      ),
      body: Column(
        children: [
          Image.file(picture),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: ElevatedButton(
              onPressed: () => _savePicture(widget.file),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Save Image',
                  style: TextStyle(
                    fontSize: 25
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
