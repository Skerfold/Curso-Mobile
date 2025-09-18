// Classe modelo de filmes

class Movie {
  // Atributos
  final int id; // Id do filme no TMDB
  final String title; // Titulo do filme
  final String posterPath; // URL da imagem do poster

  double rating; // Nota que o usuário dara ao filme ( 0 - 10 )

  // Construtor
  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    this.rating = 0.0,
  });
  // Conversores - Converter de um OBJ para dados de FireStore
  // toMap OBJ => JSON
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "posterPath": posterPath,
      "rating": rating,
    };
  }

  // Criar um OBJ a partir dos dados da API TMDE
  // fromMap Json => OBJ
  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map["id"],
      title: map["title"],
      posterPath: map["posterPath"],
    );
  }
}
