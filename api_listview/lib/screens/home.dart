import 'package:api_listview/models/travel.dart';
import 'package:api_listview/services/travel_service.dart';
import 'package:flutter/material.dart';

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
        title: const Text('Like a homeless man'),
      ),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
            width: 100,
            height: 100,
          ),
          Expanded(
            child: Column(
              children: [
                const Text('Últimas Viagens', style: TextStyle(fontSize: 18)),
                Expanded(
                  child: FutureBuilder(
                    future: _futureTravels,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data!.where((travel) => travel.date.split('/')[1] == '18').toList();
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
