// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lego_set_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LegoSetModelAdapter extends TypeAdapter<LegoSetModel> {
  @override
  final int typeId = 0;

  @override
  LegoSetModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LegoSetModel(
      id: fields[0] as String,
      name: fields[1] as String,
      setNumber: fields[2] as int,
      theme: fields[3] as String,
      pieces: fields[4] as int,
      notes: fields[5] as String,
      acquiredAt: fields[6] as String,
      collectionId: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LegoSetModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.setNumber)
      ..writeByte(3)
      ..write(obj.theme)
      ..writeByte(4)
      ..write(obj.pieces)
      ..writeByte(5)
      ..write(obj.notes)
      ..writeByte(6)
      ..write(obj.acquiredAt)
      ..writeByte(7)
      ..write(obj.collectionId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LegoSetModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LegoSetModel _$LegoSetModelFromJson(Map<String, dynamic> json) => LegoSetModel(
      id: json['id'] as String,
      name: json['name'] as String,
      setNumber: (json['setNumber'] as num).toInt(),
      theme: json['theme'] as String,
      pieces: (json['pieces'] as num).toInt(),
      notes: json['notes'] as String,
      acquiredAt: json['acquiredAt'] as String,
      collectionId: json['collectionId'] as String,
    );

Map<String, dynamic> _$LegoSetModelToJson(LegoSetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'setNumber': instance.setNumber,
      'theme': instance.theme,
      'pieces': instance.pieces,
      'notes': instance.notes,
      'acquiredAt': instance.acquiredAt,
      'collectionId': instance.collectionId,
    };
