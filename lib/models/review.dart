class Review {
  const Review({
    required this.author,
    required this.rating,
    required this.text,
    required this.date,
    this.avatarUrl,
  });

  final String author;
  final int rating;
  final String text;
  final String date;
  final String? avatarUrl;
}
