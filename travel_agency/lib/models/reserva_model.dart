class Reserva {
  final String nomeCliente;
  final DateTime dataInicio;
  final DateTime dataFim;
  final int destinoId;

  const Reserva({
    required this.nomeCliente,
    required this.dataInicio,
    required this.dataFim,
    required this.destinoId,
  });
}