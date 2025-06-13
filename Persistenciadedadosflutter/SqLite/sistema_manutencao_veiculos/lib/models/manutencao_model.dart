class Manutencao {
  int? id;
  final int veiculoId;
  final String tipoServico;
  final String data;
  final int quilometragem;
  final double custo;
  final String descricao;

  Manutencao({
    this.id,
    required this.veiculoId,
    required this.tipoServico,
    required this.data,
    required this.quilometragem,
    required this.custo,
    required this.descricao,
  });

  factory Manutencao.fromMap(Map<String, dynamic> map) {
    return Manutencao(
      id: map['id'],
      veiculoId: map['veiculoId'],
      tipoServico: map['tipoServico'],
      data: map['data'],
      quilometragem: map['quilometragem'],
      custo: map['custo'] is int ? (map['custo'] as int).toDouble() : map['custo'],
      descricao: map['descricao'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'veiculoId': veiculoId,
      'tipoServico': tipoServico,
      'data': data,
      'quilometragem': quilometragem,
      'custo': custo,
      'descricao': descricao,
    };
  }
}