//check for get_churchdata

class Church {
  String name;
  String id;

  Church({this.name, this.id});

  factory Church.fromJson(Map<String, dynamic> json) {
    return Church(
      name: json['organisation'],
      id: json['id'],
    );
  }
}



