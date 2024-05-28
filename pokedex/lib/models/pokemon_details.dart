class PokemonDetails {
  final int id;
  final String name;
  final List types;
  final String imageUrl;

  PokemonDetails({
    required this.id,
    required this.name,
    required this.types,
    required this.imageUrl,
  });

  factory PokemonDetails.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'types': List types,
      } =>
        PokemonDetails(
          id: id,
          name: name,
          types: types,
          imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png'
        ),
      _ => throw const FormatException('Failed to load details')
    };
  }
}