enum LoadType { carton, pallet, lot }

class PackingInfo {
  final String id;
  final String scanCode;
  final List<LoadType> loadTypes;
  final int loadQuantity;
  final String? packerComments;
  final List<String> photoUrls;
  final DateTime createdAt;

  PackingInfo({
    required this.id,
    required this.scanCode,
    required this.loadTypes,
    required this.loadQuantity,
    this.packerComments,
    required this.photoUrls,
    required this.createdAt,
  });
}
