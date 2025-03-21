import 'package:hive/hive.dart';

import '../models/packing_info_model.dart';

class LocalDataSource {
  final Box<PackingInfoModel> packingInfoBox;

  LocalDataSource({required this.packingInfoBox});

  Future<void> savePackingInfo(PackingInfoModel model) async {
    await packingInfoBox.put(model.id, model);
  }

  Future<PackingInfoModel?> getPackingInfoByScanCode(String scanCode) async {
    final models = packingInfoBox.values.where(
      (model) => model.scanCode == scanCode,
    );
    return models.isNotEmpty ? models.first : null;
  }

  Future<List<PackingInfoModel>> getAllPackingInfo() async {
    return packingInfoBox.values.toList();
  }
}
