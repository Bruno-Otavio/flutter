import 'package:flutter/material.dart';
import 'package:travel_agency/models/destino_model.dart';

class DestinoWidget extends StatefulWidget {
  final Destino destino;

  const DestinoWidget({
    super.key,
    required this.destino,
  });

  @override
  State<DestinoWidget> createState() => _DestinoWidgetState();
}

class _DestinoWidgetState extends State<DestinoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.grey.shade200,
            offset: const Offset(0, 3)
          )
        ]
      ),
      child: Column(
        children: [
          Text(widget.destino.nome),
          Text('R\$ ${widget.destino.valor}'),
        ],
      ),
    );
  }
}