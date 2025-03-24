import 'package:hive/hive.dart';

import '../../domain/entities/order_location.dart';

part 'order_location_model.g.dart';

@HiveType(typeId: 2)
class OrderLocationModel {
  @HiveField(0)
  final String orderId;

  @HiveField(1)
  final String location;

  OrderLocationModel({
    required this.orderId,
    required this.location,
  });

  // Convert from domain entity to model.
  factory OrderLocationModel.fromEntity(OrderLocation entity) {
    return OrderLocationModel(
      orderId: entity.orderId,
      location: entity.location,
    );
  }

  // Convert model to domain entity.
  OrderLocation toEntity() {
    return OrderLocation(
      orderId: orderId,
      location: location,
    );
  }
}
