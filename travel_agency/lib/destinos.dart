import 'package:flutter/material.dart';
import 'package:travel_agency/controller/destino_controller.dart';
import 'package:travel_agency/models/destino_model.dart';
import 'package:travel_agency/widgets/destino_widget.dart';

class DestinosPage extends StatefulWidget {
  const DestinosPage({super.key});

  @override
  State<DestinosPage> createState() => _DestinosPageState();
}

class _DestinosPageState extends State<DestinosPage> {
  late Future<List> futureDestinos;

  @override
  void initState() {
    super.initState();
    futureDestinos = DestinoController.fetchDestinos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Destinos'),
      ),
      body: FutureBuilder(
        future: futureDestinos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List destinos = snapshot.data!;
            return _buildDestinos(destinos);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }

  GridView _buildDestinos(List<dynamic> destinos) {
    double gap = 10;

    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 1 / 1,
      padding: const EdgeInsets.all(12),
      crossAxisSpacing: gap,
      mainAxisSpacing: gap,
      children: List.generate(destinos.length, (index) {
        final Destino destino = destinos[index];
        return DestinoWidget(destino: destino);
      }),
    );
  }
}
