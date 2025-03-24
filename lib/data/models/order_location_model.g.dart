// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_location_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderLocationModelAdapter extends TypeAdapter<OrderLocationModel> {
  @override
  final int typeId = 1;

  @override
  OrderLocationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderLocationModel(
      orderId: fields[0] as String,
      location: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, OrderLocationModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.orderId)
      ..writeByte(1)
      ..write(obj.location);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderLocationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
