class Genres {
  late final String id;
  late final String name;

  Genres({required this.id, required this.name});

  // Phương thức toMap
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  // Phương thức fromMap
  factory Genres.fromMap(Map<String, dynamic> map) {
    return Genres(
      id: map['id'],
      name: map['name'],
    );
  }
}
