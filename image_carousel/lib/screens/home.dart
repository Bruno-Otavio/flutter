import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_carousel/screens/video.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _images = const [
    <String, dynamic>{
      'image': 'assets/images/cabeca.webp',
      'video': 'assets/videos/domain-expansion.mp4',
    },
    <String, dynamic>{
      'image': 'assets/images/colheitadeira.webp',
      'video': 'assets/videos/avi_video.avi',
    },
    <String, dynamic>{
      'image': 'assets/images/gado.webp',
      'video': 'assets/videos/Toast-falling-over.mp4',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Carousel'),
        centerTitle: true,
      ),
      body: CarouselSlider(
        options: CarouselOptions(height: 400, ),
        items: _images.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPage(item: item,)),);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.grey.shade100),
                    child: Image.asset(
                      item['image'],
                      height: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
