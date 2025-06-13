class Veiculo {
  int? id;
  final String marca;
  final String modelo;
  final int ano;
  final String placa;
  final double quilometragemInicial;

  Veiculo({
    this.id,
    required this.marca,
    required this.modelo,
    required this.ano,
    required this.placa,
    required this.quilometragemInicial,
  });

  factory Veiculo.fromMap(Map<String, dynamic> map) {
    return Veiculo(
      id: map['id'],
      marca: map['marca'],
      modelo: map['modelo'],
      ano: map['ano'],
      placa: map['placa'],
      quilometragemInicial: map['quilometragemInicial'] is int
          ? (map['quilometragemInicial'] as int).toDouble()
          : map['quilometragemInicial'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'marca': marca,
      'modelo': modelo,
      'ano': ano,
      'placa': placa,
      'quilometragemInicial': quilometragemInicial,
    };
  }
}