import '../entities/packing_info.dart';
import '../repositories/package_repository.dart';

class GetPackingInfoUseCase {
  final PackageRepository repository;

  GetPackingInfoUseCase(this.repository);

  Future<PackingInfo?> execute(String scanCode) {
    return repository.getPackingInfoByScanCode(scanCode);
  }
}
