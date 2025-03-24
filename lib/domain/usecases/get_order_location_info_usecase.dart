import '../entities/order_location.dart';
import '../repositories/order_location_repository.dart';

class GetOrderLocationUseCase {
  final OrderLocationRepository repository;

  GetOrderLocationUseCase(this.repository);

  Future<OrderLocation?> execute(String orderId) {
    return repository.getOrderLocationByOrderId(orderId);
  }
}
