// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packing_info_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PackingInfoModelAdapter extends TypeAdapter<PackingInfoModel> {
  @override
  final int typeId = 1;

  @override
  PackingInfoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PackingInfoModel(
      id: fields[0] as String,
      scanCode: fields[1] as String,
      loadTypes: (fields[2] as List).cast<int>(),
      loadQuantity: fields[3] as int,
      packerComments: fields[4] as String?,
      photoUrls: (fields[5] as List).cast<String>(),
      createdAt: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, PackingInfoModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.scanCode)
      ..writeByte(2)
      ..write(obj.loadTypes)
      ..writeByte(3)
      ..write(obj.loadQuantity)
      ..writeByte(4)
      ..write(obj.packerComments)
      ..writeByte(5)
      ..write(obj.photoUrls)
      ..writeByte(6)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PackingInfoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
