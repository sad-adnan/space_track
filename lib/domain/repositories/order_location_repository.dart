import '../entities/order_location.dart';

abstract class OrderLocationRepository {
  Future<OrderLocation?> getOrderLocationByOrderId(String orderId);
}
