class Eletroposto {
  final int id;
  final String nome;
  final String informacoes;
  final String endereco;
  final String telefone;

  Eletroposto(
    this.id,
    this.nome,
    this.informacoes,
    this.endereco,
    this.telefone,
  );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'informacoes': informacoes,
        'endereco': endereco,
        'telefone': telefone,
      };

  Eletroposto.fromJson(Map json)
      : id = json['id'],
        nome = json['nome'],
        informacoes = json['informacoes'],
        endereco = json['endereco'],
        telefone = json['telefone'];
}
