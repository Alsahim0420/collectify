import 'package:equatable/equatable.dart';

class Collection extends Equatable {
  const Collection({
    required this.id,
    required this.name,
    required this.description,
    required this.color,
    required this.createdAt,
    this.setCount = 0,
  });
  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      color: json['color'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      setCount: json['setCount'] as int? ?? 0,
    );
  }

  final String id;
  final String name;
  final String description;
  final int color; // Color como entero para MaterialColor
  final DateTime createdAt;
  final int setCount;

  Collection copyWith({
    String? name,
    String? description,
    int? color,
    int? setCount,
  }) => Collection(
    id: id,
    name: name ?? this.name,
    description: description ?? this.description,
    color: color ?? this.color,
    createdAt: createdAt,
    setCount: setCount ?? this.setCount,
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'color': color,
      'createdAt': createdAt.toIso8601String(),
      'setCount': setCount,
    };
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    color,
    createdAt,
    setCount,
  ];
}
