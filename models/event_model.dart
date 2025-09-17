class EventModel {
  final String id;
  final String title;
  final DateTime date;
  final String description;

  EventModel({
    required this.id,
    required this.title,
    required this.date,
    required this.description,
  });

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'],
      title: map['title'],
      date: DateTime.parse(map['date']),
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'description': description,
    };
  }
}
