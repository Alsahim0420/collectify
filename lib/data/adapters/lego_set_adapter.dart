import 'package:hive/hive.dart';
import 'package:collectify/data/models/lego_set_model.dart';

class LegoSetAdapter extends TypeAdapter<LegoSetModel> {
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
      collectionId: fields[7] as String? ?? 'default',
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
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LegoSetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;

  @override
  int get hashCode => typeId.hashCode;
}
