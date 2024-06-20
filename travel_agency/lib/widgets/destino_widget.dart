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
                offset: const Offset(0, 3))
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(widget.destino.nome),
          Text('R\$ ${widget.destino.valor}'),
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) => _modal());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            child: Text(
              'Reservar',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _modal() {
    return SizedBox(
      height: 500,
      child: Center(
          child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          FormReservas(),
        ],
      )),
    );
  }
}

class FormReservas extends StatelessWidget {
  FormReservas({
    super.key,
  });

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Digite seu Nome',
                filled: true,
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.blue,
                  )
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
