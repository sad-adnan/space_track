import '../entities/packing_info.dart';

abstract class PackageRepository {
  Future<void> savePackingInfo(PackingInfo packingInfo);
  Future<PackingInfo?> getPackingInfoByScanCode(String scanCode);
  Future<List<PackingInfo>> getAllPackingInfo();
}
