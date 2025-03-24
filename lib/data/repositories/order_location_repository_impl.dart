import '../../domain/entities/order_location.dart';
import '../../domain/repositories/order_location_repository.dart';
import '../datasources/local_data_source.dart';

class OrderLocationRepositoryImpl implements OrderLocationRepository {
  final LocalDataSource localDataSource;

  OrderLocationRepositoryImpl({required this.localDataSource});

  @override
  Future<OrderLocation?> getOrderLocationByOrderId(String orderId) async {
    final model = await localDataSource.getOrderLocationByOrderId(orderId);
    return model?.toEntity();
  }

}
