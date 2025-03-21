import '../../domain/entities/packing_info.dart';
import '../../domain/repositories/package_repository.dart';
import '../datasources/local_data_source.dart';
import '../models/packing_info_model.dart';

class PackageRepositoryImpl implements PackageRepository {
  final LocalDataSource localDataSource;

  PackageRepositoryImpl({required this.localDataSource});

  @override
  Future<void> savePackingInfo(PackingInfo packingInfo) async {
    final model = PackingInfoModel.fromEntity(packingInfo);
    await localDataSource.savePackingInfo(model);
  }

  @override
  Future<PackingInfo?> getPackingInfoByScanCode(String scanCode) async {
    final model = await localDataSource.getPackingInfoByScanCode(scanCode);
    return model?.toEntity();
  }

  @override
  Future<List<PackingInfo>> getAllPackingInfo() async {
    final models = await localDataSource.getAllPackingInfo();
    return models.map((model) => model.toEntity()).toList();
  }
}
