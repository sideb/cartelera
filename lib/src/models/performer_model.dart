///
/// Clase para el reparto de una película.
/// Es una lista de actores
///
class Cast {
  List<Performer> performers = new List();

  // Constructor que devuelve la lista a partir de un json de actores
  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((element) {
      final performer = Performer.fromJsonMap(element);
      performers.add(performer);
    });
  }
}

///
/// Clase para un actor
///
class Performer {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  // Constructor
  Performer({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  // Constructor a partir de un json
  Performer.fromJsonMap(Map<String, dynamic> json) {
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    profilePath = json['profile_path'];
  }

  // Método que obtiene la foto del actor
  getProfileImg() {
    if (profilePath == null) {
      return 'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}
