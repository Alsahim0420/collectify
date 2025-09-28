import 'package:equatable/equatable.dart';

class LegoSet extends Equatable {
  const LegoSet({
    required this.id,
    required this.name,
    required this.setNumber,
    required this.theme,
    required this.pieces,
    required this.notes,
    required this.acquiredAt,
    required this.collectionId,
  });
  final String id;
  final String name;
  final int setNumber;
  final String theme;
  final int pieces;
  final String notes;
  final DateTime acquiredAt;
  final String collectionId;

  LegoSet copyWith({
    String? name,
    int? setNumber,
    String? theme,
    int? pieces,
    String? notes,
    String? collectionId,
  }) => LegoSet(
    id: id,
    name: name ?? this.name,
    setNumber: setNumber ?? this.setNumber,
    theme: theme ?? this.theme,
    pieces: pieces ?? this.pieces,
    notes: notes ?? this.notes,
    acquiredAt: acquiredAt,
    collectionId: collectionId ?? this.collectionId,
  );

  @override
  List<Object?> get props => [
    id,
    name,
    setNumber,
    theme,
    pieces,
    notes,
    acquiredAt,
    collectionId,
  ];
}
