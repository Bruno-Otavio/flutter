class Travel {
  const Travel({
    required this.id,
    required this.idUser,
    required this.origin,
    required this.destination,
    required this.rate,
    required this.price,
    required this.distance,
    required this.date,
  });

  final String id;
  final String idUser;
  final String origin;
  final String destination;
  final double rate;
  final double price;
  final double distance;
  final String date;

  factory Travel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'id_user': String idUser,
        'origin': String origin,
        'destination': String destination,
        'rate': dynamic rate,
        'price': double price,
        'distance': double distance,
        'date': String date,
      } =>
        Travel(
          id: id,
          idUser: idUser,
          origin: origin,
          destination: destination,
          rate: rate.runtimeType == int ? rate.toDouble() : rate,
          price: price,
          distance: distance,
          date: date,
        ),
      _ => throw const FormatException('Failed to load travel.')
    };
  }
}
