class Ponto {
  final int id;
  final String nome;
  final String endereco;
  final String telefone;
  final int valor;

  const Ponto({
    required this.id,
    required this.nome,
    required this.endereco,
    required this.telefone,
    required this.valor,
  });

  factory Ponto.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'nome': String nome,
        'endereco': String endereco,
        'telefone': String telefone,
        'valor': int valor,
      } =>
        Ponto(
          id: id,
          nome: nome,
          endereco: endereco,
          telefone: telefone,
          valor: valor,
        ),
      _ => throw const FormatException('Failed to load Ponto'),
    };
  }
}