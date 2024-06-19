import 'package:travel_agency/models/hotel_model.dart';
import 'package:travel_agency/models/pontos_model.dart';

class Destino {
  final int id;
  final String nome;
  final int valor;
  final List pontosList;
  final List hoteisList;

  get pontos {
    return pontosList.map((e) => Ponto.fromJson(e)).toList();
  }

  get hoteis {
    return hoteisList.map((e) => Hotel.fromJson(e)).toList();
  }

  const Destino({
    required this.id,
    required this.nome,
    required this.valor,
    required this.pontosList,
    required this.hoteisList,
  });

  factory Destino.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'nome': String nome,
        'valor': int valor,
        'pontos': List pontos,
        'hoteis': List hoteis,
      } =>
        Destino(
          id: id,
          nome: nome,
          valor: valor,
          pontosList: pontos,
          hoteisList: hoteis,
        ),
      _ => throw const FormatException('Failed to load Destinos'),
    };
  }
}