import 'dart:io';

import 'package:audio/widgets/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:path/path.dart' as p;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  final AudioRecorder _audioRecorder = AudioRecorder();
  bool _isRecording = false;

  String? _recordingPath;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Player'),
      ),
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () async {
              await _audioPlayer.setFilePath(_recordingPath!);
              _audioPlayer.play();
            },
            child: const Text('Play Audio'),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_isRecording) {
            String? filePath = await _audioRecorder.stop();
            if (filePath != null) {
              setState(() {
                _isRecording = false;
                _recordingPath = filePath;
              });
            }
          } else {
            if (await _audioRecorder.hasPermission()) {
              final Directory appDocumentsDir =
                  await getApplicationDocumentsDirectory();
              final String filePath =
                  p.join(appDocumentsDir.path, 'record.wav');

              await _audioRecorder.start(
                const RecordConfig(),
                path: filePath,
              );

              setState(() {
                _isRecording = !_isRecording;
                _recordingPath = null;
              });
            }
          }
        },
        child: !_isRecording ? const Icon(Icons.mic) : const Icon(Icons.pause),
      ),
      drawer: const MenuDrawer(),
    );
  }
}
