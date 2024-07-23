import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_agency/controller/reserva_controller.dart';
import 'package:travel_agency/models/destino_model.dart';
import 'package:travel_agency/models/reserva_model.dart';

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
    final LatLng pPlex = LatLng(widget.destino.lat, widget.destino.long);
    return SizedBox(
      height: 500,
      child: Center(
          child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 75, vertical: 10),
            child: Divider(thickness: 3,),
          ),
          FormReservas(destino: widget.destino),
          Expanded(
            child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: pPlex,
                  zoom: 13.5,
                ),
                mapType: MapType.normal,
                zoomControlsEnabled: false,
                zoomGesturesEnabled: false,
                markers: {
                  Marker(
                    markerId: const MarkerId('_currentLocation'),
                    icon: BitmapDescriptor.defaultMarker,
                    position: pPlex
                  )
                },
              )
            ),
          ],
        )
      ),
    );
  }
}

class FormReservas extends StatefulWidget {
  final Destino destino;

  const FormReservas({
    super.key,
    required this.destino,
  });

  @override
  State<FormReservas> createState() => _FormReservasState();
}

class _FormReservasState extends State<FormReservas> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nomeClienteController = TextEditingController();
  final TextEditingController _dateInicioController = TextEditingController();
  final TextEditingController _dateFimController = TextEditingController();

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );

    if (picked != null) {
      List date = picked.toString().split(' ')[0].split('-');
      setState(() {
        controller.text =
            '${date[date.length - 1]}/${date[date.length - 2]}/${date[date.length - 3]}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nomeClienteController,
              validator: (value) {
                if (value == null) {
                  return 'Por favor, insira seu nome.';
                }
              },
              decoration: const InputDecoration(
                  labelText: 'Digite seu Nome',
                  filled: true,
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    width: 1,
                    color: Colors.blue,
                  ))),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _dateInicioController,
                    readOnly: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira uma data de início.';
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Data de Início',
                      prefixIcon: Icon(Icons.calendar_month),
                      border: InputBorder.none,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 1,
                        color: Colors.blue,
                      )),
                    ),
                    onTap: () {
                      _selectDate(context, _dateInicioController);
                    },
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: TextFormField(
                    controller: _dateFimController,
                    readOnly: true,
                    validator: (value) {
                      if (value == null) {
                        return 'Por favor, insira uma data de fim.';
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Data de Fim',
                      prefixIcon: Icon(Icons.calendar_month),
                      border: InputBorder.none,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 1,
                        color: Colors.blue,
                      )),
                    ),
                    onTap: () {
                      _selectDate(context, _dateFimController);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final List dateInicio = _dateInicioController.text.split('/');
                  final List dateFim = _dateFimController.text.split('/');

                  final Reserva reserva = Reserva(
                      nomeCliente: _nomeClienteController.text,
                      dataInicio: DateTime(
                        int.parse(dateInicio[dateInicio.length - 1]),
                        int.parse(dateInicio[dateInicio.length - 2]),
                        int.parse(dateInicio[dateInicio.length - 3]),
                      ),
                      dataFim: DateTime(
                        int.parse(dateFim[dateFim.length - 1]),
                        int.parse(dateFim[dateFim.length - 2]),
                        int.parse(dateFim[dateFim.length - 3]),
                      ),
                      destinoId: widget.destino.id);

                  final Map<String, dynamic> data = {
                    'nomeCliente': reserva.nomeCliente,
                    'dataInicio': reserva.dataInicio,
                    'dataFim': reserva.dataFim,
                    'destinoId': reserva.destinoId,
                  };

                  ReservaController.createReserva(data).then((response) {
                    if (response.statusCode == 201) {
                      return const SnackBar(
                          content: Text('Reserva criada com sucesso.'));
                    }
                    return const SnackBar(
                        content: Text('Falha ao criar reserva.'));
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              child: Text(
                'Concluir Reserva',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
