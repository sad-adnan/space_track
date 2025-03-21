import '../entities/packing_info.dart';
import '../repositories/package_repository.dart';

class SavePackingInfoUseCase {
  final PackageRepository repository;

  SavePackingInfoUseCase(this.repository);

  Future<void> execute(PackingInfo packingInfo) {
    return repository.savePackingInfo(packingInfo);
  }
}
