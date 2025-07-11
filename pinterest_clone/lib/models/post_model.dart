class PostModel {
  final String? id;
  final String title;
  final String description;
  final String imageUrl;
  final String? userId; // Optional jika kamu ingin pakai userId

  PostModel({
    this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.userId,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] ?? json['_id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'userId': userId,
    };
  }
}
