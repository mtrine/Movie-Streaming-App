class Review{
  late final String? user_id;
  late final String? movie_id;
  late final int? rating;
  late final String? review;
  late final String? created_at;
  late final String? updated_at;

  Review({
    required this.user_id,
    required this.movie_id,
    required this.rating,
    required this.review,
    required this.created_at,
    required this.updated_at,
  });

  factory Review.fromMap(Map<String, dynamic> map) {
    try{
      return Review(
        user_id: map['user_id'],
        movie_id: map['movie_id'],
        rating: map['rating'],
        review: map['review_text'],
        created_at: map['created_at'],
        updated_at: map['updated_at'],
      );
    }
    catch(e){
      print("Error Review: ${e}");
      return Review(user_id: "", movie_id: "", rating: 0, review: "", created_at: "", updated_at: "");
    }
  }
}