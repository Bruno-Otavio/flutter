import 'dart:math';

import 'package:api_listview/models/travel.dart';
import 'package:api_listview/services/travel_service.dart';
import 'package:api_listview/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Future<List<Travel>> _futureTravels = TravelService.getTravels();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test App'),
        leading: const Icon(Icons.arrow_back),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              IconButton.outlined(
                onPressed: () {},
                icon: const Icon(Icons.arrow_back),
                style: IconButton.styleFrom(
                  side: const BorderSide(color: Colors.blue)
                ),
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme();
                },
                child: Container(
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.15),
                  width: double.infinity,
                  height: 100,
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                Text('${Random().nextInt(50)}'),
                const Text('Últimas Viagens', style: TextStyle(fontSize: 18)),
                Expanded(
                  child: FutureBuilder(
                    future: _futureTravels,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data!
                            .where(
                                (travel) => travel.date.split('/')[1] == '18')
                            .toList();
                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final Travel travel = data[index];
                            return Text(travel.destination);
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
