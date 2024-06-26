class Movies {
  final String? id;
  final String? title;
  final String? description;
  final String? videoUrl;
  final String? posterImg;
  final String? releaseDate;
  final String? createdAt;
  final String? updatedAt;

  const Movies({
    this.id,
    this.title,
    this.description,
    this.videoUrl,
    this.posterImg,
    this.releaseDate,
    this.createdAt,
    this.updatedAt,
  });

  // Phương thức toMap
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'video_url': videoUrl,
      'image_url': posterImg,
      'release_date': releaseDate,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  // Phương thức fromMap
  factory Movies.fromMap(Map<String, dynamic> map) {
    try{
      return Movies(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        videoUrl: map['video_url'],
        posterImg: map['image_url'],
        releaseDate: map['release_date'],
        createdAt: map['created_at'],
        updatedAt: map['updated_at'],
      );
    } catch (e) {
      print('Error Movies.fromMap: $e');
      return Movies();
    }
  }
}


