import 'package:hive/hive.dart';

import '../models/order_location_model.dart';
import '../models/packing_info_model.dart';

class LocalDataSource {
  final Box<PackingInfoModel> packingInfoBox;
  final Box<OrderLocationModel> orderLocationBox;

  LocalDataSource( {required this.packingInfoBox,required this.orderLocationBox,});

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

  Future<OrderLocationModel?> getOrderLocationByOrderId(String orderId) async{
    final models = orderLocationBox.values.where(
          (model) => model.orderId == orderId,
    );
    return models.isNotEmpty ? models.first : null;
  }
}
