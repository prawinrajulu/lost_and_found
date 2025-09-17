class ItemModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final bool isLost;
  final String location;
  final DateTime date;

  ItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.isLost,
    required this.location,
    required this.date,
  });

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      isLost: map['isLost'],
      location: map['location'],
      date: DateTime.parse(map['date']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'isLost': isLost,
      'location': location,
      'date': date.toIso8601String(),
    };
  }
}
