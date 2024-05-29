class RatingEntity {
  final double rate;
  final int count;
  RatingEntity({
    required this.rate,
    required this.count,
  });

  factory RatingEntity.fromJson(Map<String, dynamic> json) {
    return RatingEntity(
      rate: json['rate'].toDouble(),
      count: json['count'] as int,
    );
  }
  
}
