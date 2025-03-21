import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:space_track/presentation/packing-info/controllers/packing_info_controller.dart';

import '../../../data/datasources/local_data_source.dart';
import '../../../data/models/packing_info_model.dart';
import '../../../data/repositories/package_repository_impl.dart';
import '../../../domain/usecases/get_packing_info_usecase.dart';
import '../../../domain/usecases/save_packing_info_usecase.dart';



class PackingInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.putAsync<Box<PackingInfoModel>>(() async {
      return await Hive.openBox<PackingInfoModel>('packingInfo');
    });

    Get.lazyPut<LocalDataSource>(() {
      final packingInfoBox = Get.find<Box<PackingInfoModel>>();
      return LocalDataSource(packingInfoBox: packingInfoBox);
    });

    Get.lazyPut<PackageRepositoryImpl>(() {
      final localDataSource = Get.find<LocalDataSource>();
      return PackageRepositoryImpl(localDataSource: localDataSource);
    });

    Get.lazyPut<SavePackingInfoUseCase>(() {
      final packageRepository = Get.find<PackageRepositoryImpl>();
      return SavePackingInfoUseCase(packageRepository);
    });

    Get.lazyPut<GetPackingInfoUseCase>(() {
      final packageRepository = Get.find<PackageRepositoryImpl>();
      return GetPackingInfoUseCase(packageRepository);
    });

    Get.lazyPut<PackingInfoController>(() {
      return PackingInfoController(
        savePackingInfoUseCase: Get.find<SavePackingInfoUseCase>(),
        getPackingInfoUseCase: Get.find<GetPackingInfoUseCase>(),
      );
    });
  }
}
