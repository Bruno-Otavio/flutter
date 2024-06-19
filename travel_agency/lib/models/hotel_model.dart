class Hotel {
  final int id;
  final String nome;
  final String avaliacao;
  final String email;
  final String site;
  final int valor;

  const Hotel({
    required this.id,
    required this.nome,
    required this.avaliacao,
    required this.email,
    required this.site,
    required this.valor,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'nome': String nome,
        'avaliacao': String avaliacao,
        'email': String email,
        'site': String site,
        'valor': int valor,
      } =>
        Hotel(
          id: id,
          nome: nome,
          avaliacao: avaliacao,
          email: email,
          site: site,
          valor: valor,
        ),
      _ => throw const FormatException('Failed to load Ponto'),
    };
  }
}