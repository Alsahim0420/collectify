import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';
import 'package:collectify/domain/entities/lego_set.dart';

part 'lego_set_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class LegoSetModel {
  const LegoSetModel({
    required this.id,
    required this.name,
    required this.setNumber,
    required this.theme,
    required this.pieces,
    required this.notes,
    required this.acquiredAt,
    required this.collectionId,
  });

  factory LegoSetModel.fromJson(Map<String, dynamic> json) =>
      _$LegoSetModelFromJson(json);

  factory LegoSetModel.fromEntity(LegoSet e) => LegoSetModel(
    id: e.id,
    name: e.name,
    setNumber: e.setNumber,
    theme: e.theme,
    pieces: e.pieces,
    notes: e.notes,
    acquiredAt: e.acquiredAt.toIso8601String(),
    collectionId: e.collectionId,
  );
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int setNumber;

  @HiveField(3)
  final String theme;

  @HiveField(4)
  final int pieces;

  @HiveField(5)
  final String notes;

  @HiveField(6)
  final String acquiredAt;

  @HiveField(7)
  final String collectionId;

  Map<String, dynamic> toJson() => _$LegoSetModelToJson(this);

  LegoSet toEntity() => LegoSet(
    id: id,
    name: name,
    setNumber: setNumber,
    theme: theme,
    pieces: pieces,
    notes: notes,
    acquiredAt: DateTime.parse(acquiredAt),
    collectionId: collectionId,
  );
}
