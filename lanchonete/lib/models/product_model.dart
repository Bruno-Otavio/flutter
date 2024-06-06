class Product {
  final int id;
  final String nome;
  final String img;
  final dynamic preco;

  const Product({
    required this.id,
    required this.nome,
    required this.img,
    required this.preco,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'nome': String nome,
        'img': String img,
        'preco': dynamic preco,
      } => 
        Product(
          id: id,
          nome: nome,
          img: img,
          preco: preco,
        ),
      _ => throw const FormatException('Failed to load product'),
    };
  }
}