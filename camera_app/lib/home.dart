import 'package:camera/camera.dart';
import 'package:camera_app/image_preview.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CameraDescription> _cameras = [];
  CameraController? _cameraController;

  Future<void> _setupCameraController() async {
    List<CameraDescription> cameras = await availableCameras();

    if (cameras.isNotEmpty) {
      setState(() {
        _cameras = cameras;
        _cameraController =
            CameraController(cameras.first, ResolutionPreset.max);
      });

      _cameraController?.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _setupCameraController();
  }

  @override
  Widget build(BuildContext context) {
    return _buildUI();
  }

  Widget _buildUI() {
    if (_cameraController == null ||
        _cameraController?.value.isInitialized == false) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SafeArea(
      child: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.70,
              child: CameraPreview(
                _cameraController!,
              ),
            ),
            IconButton(
              onPressed: () async {
                try {
                  XFile picture = await _cameraController!.takePicture();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImagePreview(picture),
                    ),
                  );
                } on CameraException catch (e) {
                  debugPrint('Error ocurred while taking picture : $e');
                }
              },
              iconSize: 75,
              icon: const Icon(Icons.camera),
            )
          ],
        ),
      ),
    );
  }
}
