class Task {
  final String id;
  final String title;
  final String description;
  final bool isDone;
  final DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    this.description = '',
    this.isDone = false,
    required this.createdAt,
  });

  // Converte Firestore → Task
  factory Task.fromMap(Map<String, dynamic> map, String id) {
    return Task(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      isDone: map['isDone'] ?? false,
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as dynamic).toDate()
          : DateTime.now(),
    );
  }

  // Converte Task → Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'isDone': isDone,
      'createdAt': createdAt,
    };
  }

  // Cria uma cópia com campos alterados
  Task copyWith({
    String? title,
    String? description,
    bool? isDone,
  }) {
    return Task(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt,
    );
  }
}
