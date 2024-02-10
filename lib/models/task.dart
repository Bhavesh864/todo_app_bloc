import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Task extends Equatable {
  final String title;
  final String id;
  bool? isCompleted;
  bool? isDeleted;

  Task({
    required this.title,
    required this.id,
    this.isCompleted,
    this.isDeleted,
  }) {
    isCompleted = isCompleted ?? false;
    isDeleted = isDeleted ?? false;
  }

  Task copyWith({
    String? title,
    String? id,
    bool? isCompleted,
    bool? isDeleted,
  }) {
    return Task(
      title: title ?? this.title,
      id: id ?? this.id,
      isCompleted: isCompleted ?? this.isCompleted,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'id': id,
      'isCompleted': isCompleted,
      'isDeleted': isDeleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] as String,
      id: map['id'] as String,
      isCompleted: map['isCompleted'] != null ? map['isCompleted'] as bool : null,
      isDeleted: map['isDeleted'] != null ? map['isDeleted'] as bool : null,
    );
  }

  @override
  List<Object?> get props => [
        title,
        id,
        isCompleted,
        isDeleted,
      ];
}
