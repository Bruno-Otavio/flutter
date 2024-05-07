import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 25),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(100)
              ),
              child: Icon(
                Icons.person,
                color: Colors.grey[100],
                size: 75,
              ),
            ),
          )
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Profile Page',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
