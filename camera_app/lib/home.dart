import 'package:camera/camera.dart';
import 'package:camera_app/image_list.dart';
import 'package:camera_app/image_preview.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  List<CameraDescription> _cameras = [];
  CameraController? _cameraController;
  bool isFrontCamera = false;

  Future<void> _setupCameraController(int camera) async {
    List<CameraDescription> cameras = await availableCameras();

    if (cameras.isNotEmpty) {
      setState(() {
        _cameras = cameras;
        _cameraController =
            CameraController(_cameras[camera], ResolutionPreset.max);
      });

      _cameraController?.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      }).catchError((Object e) {
        debugPrint('$e');
      });
    }
  }

  Future<void> _takePicture() async {
    XFile? picture;

    if (_cameraController!.value.isTakingPicture ||
        !_cameraController!.value.isInitialized) {
      return;
    }

    try {
      picture = await _cameraController!.takePicture();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImagePreview(picture!),
        ),
      );
    } on CameraException catch (e) {
      debugPrint('Error ocurred while taking picture : $e');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      _cameraController?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _setupCameraController(0);
    }
  }

  @override
  void initState() {
    super.initState();
    _setupCameraController(0);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _showCamera(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ImageList(),
                        ),
                      );
                    },
                    iconSize: 50,
                    icon: const Icon(Icons.image),
                  ),
                  IconButton(
                    onPressed: _takePicture,
                    iconSize: 75,
                    icon: const Icon(Icons.camera),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isFrontCamera = !isFrontCamera;
                      });
              
                      // Change between frontal and back camera
                      isFrontCamera
                          ? _setupCameraController(1)
                          : _setupCameraController(0);
                    },
                    iconSize: 50,
                    icon: const Icon(Icons.flip_camera_android),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _showCamera() {
    if (_cameraController == null ||
        _cameraController?.value.isInitialized == false) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.70,
      child: CameraPreview(
        _cameraController!,
      ),
    );
  }
}
