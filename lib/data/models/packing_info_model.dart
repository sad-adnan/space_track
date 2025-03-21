import 'package:hive/hive.dart';

import '../../domain/entities/packing_info.dart';

part 'packing_info_model.g.dart';

@HiveType(typeId: 1)
class PackingInfoModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String scanCode;

  // Updated field to store multiple load types as list of ints.
  @HiveField(2)
  final List<int> loadTypes;

  @HiveField(3)
  final int loadQuantity;

  @HiveField(4)
  final String? packerComments;

  @HiveField(5)
  final List<String> photoUrls;

  @HiveField(6)
  final DateTime createdAt;

  PackingInfoModel({
    required this.id,
    required this.scanCode,
    required this.loadTypes,
    required this.loadQuantity,
    this.packerComments,
    required this.photoUrls,
    required this.createdAt,
  });

  // Convert from domain entity to model.
  factory PackingInfoModel.fromEntity(PackingInfo info) {
    return PackingInfoModel(
      id: info.id,
      scanCode: info.scanCode,
      loadTypes: info.loadTypes.map((e) => e.index).toList(),
      loadQuantity: info.loadQuantity,
      packerComments: info.packerComments,
      photoUrls: info.photoUrls,
      createdAt: info.createdAt,
    );
  }

  // Convert model to domain entity.
  PackingInfo toEntity() {
    return PackingInfo(
      id: id,
      scanCode: scanCode,
      loadTypes: loadTypes.map((i) => LoadType.values[i]).toList(),
      loadQuantity: loadQuantity,
      packerComments: packerComments,
      photoUrls: photoUrls,
      createdAt: createdAt,
    );
  }
}
