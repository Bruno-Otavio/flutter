import 'package:flutter/material.dart';
import 'package:pokedex/services/database_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final DatabaseService _databaseService = DatabaseService.instance;

  Future<int> getTotalFavorites() async {
    final data = await _databaseService.getFavorites();
    return data.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 50,),

          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              shape: BoxShape.circle
            ),
            child: const Icon(
              Icons.person,
              color: Colors.red,
              size: 100,
            ),
          ),

          const SizedBox(height: 50,),

          Center(
            child: FutureBuilder(
              future: getTotalFavorites(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final int total = snapshot.data!;
                  if (total != 0) {
                    return Text(
                      'Total Favorites: $total',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    );
                  } else {
                    return const Text(
                      'You do not have any favorites.',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    );
                  }
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
            
                return const Center(child: CircularProgressIndicator(),);
              },
            ),
          )
        ],
      ),
    );
  }
}