class Eletroposto {
  final String nome;
  final String informacoes;
  final String endereco;
  final String telefone;

  Eletroposto(
    this.nome,
    this.informacoes,
    this.endereco,
    this.telefone,
  );

  Map<String, dynamic> toJson() => {
        'nome': nome,
        'informacoes': informacoes,
        'endereco': endereco,
        'telefone': telefone,
      };

  Eletroposto.fromJson(Map json)
      : nome = json['nome'],
        informacoes = json['informacoes'],
        endereco = json['endereco'],
        telefone = json['telefone'];
}
