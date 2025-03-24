import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:space_track/data/repositories/order_location_repository_impl.dart';
import 'package:space_track/domain/usecases/get_order_location_info_usecase.dart';

import '../../../data/datasources/local_data_source.dart';
import '../../../data/models/order_location_model.dart';
import '../../../data/models/packing_info_model.dart';
import '../controllers/order_location_controller.dart';



class OrderLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.putAsync<Box<PackingInfoModel>>(() async {
      return await Hive.openBox<PackingInfoModel>('packingInfo');
    });

    Get.putAsync<Box<OrderLocationModel>>(() async {
      return await Hive.openBox<OrderLocationModel>('orderLocation');
    });

    Get.lazyPut<LocalDataSource>(() {
      final packingInfoBox = Get.find<Box<PackingInfoModel>>();
      final orderLocationBox = Get.find<Box<OrderLocationModel>>();
      return LocalDataSource(packingInfoBox: packingInfoBox,orderLocationBox: orderLocationBox);
    });

    Get.lazyPut<OrderLocationRepositoryImpl>(() {
      final localDataSource = Get.find<LocalDataSource>();
      return OrderLocationRepositoryImpl(localDataSource: localDataSource);
    });

    Get.lazyPut<GetOrderLocationUseCase>(() {
      final orderRepository = Get.find<OrderLocationRepositoryImpl>();
      return GetOrderLocationUseCase(orderRepository);
    });


    Get.lazyPut<OrderLocationController>(() {
      return OrderLocationController(
        getOrderLocationUseCase: Get.find<GetOrderLocationUseCase>(),
      );
    });
  }
}
