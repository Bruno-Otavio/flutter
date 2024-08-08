import 'package:flutter/material.dart';
import 'package:image_carousel/widgets/video_player_view.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  final Map<String, dynamic> item;

  const VideoPage({
    super.key,
    required this.item,
  });

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video'),
        centerTitle: true,
      ),
      body: VideoPlayerView(
        url: widget.item['video'],
        dataSourceType: DataSourceType.asset,
      ),
    );
  }
}
