class Pokemon {
  final int id;
  final String name;
  final String? url;
  final String imageUrl;

  const Pokemon({
    required this.id,
    required this.name,
    this.url,
    required this.imageUrl,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json, int id) {
    return switch (json) {
      {
        'name': String name,
        'url': String url,
      } => 
        Pokemon(
          id: id + 1,
          name: name,
          url: url,
          imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${id + 1}.png'
        ),
      _ => throw const FormatException('Failed to load pokemon'),
    };
  }
}
