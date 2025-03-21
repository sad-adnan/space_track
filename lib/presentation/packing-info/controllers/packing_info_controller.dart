import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:space_track/core/app_route_constants.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/entities/packing_info.dart';
import '../../../domain/usecases/get_packing_info_usecase.dart';
import '../../../domain/usecases/save_packing_info_usecase.dart';


class PackingInfoController extends GetxController {
  final SavePackingInfoUseCase savePackingInfoUseCase;
  final GetPackingInfoUseCase getPackingInfoUseCase;
  final ImagePicker _picker = ImagePicker();

  PackingInfoController({
    required this.savePackingInfoUseCase,
    required this.getPackingInfoUseCase,
  });

  final selectedLoadTypes = <LoadType>[].obs;
  final loadQuantity = 1.obs;
  final packerComments = ''.obs;
  final photoUrls = <String>[].obs;

  final isLoading = false.obs;
  final isDataSaved = false.obs;
  final isValid = false.obs;
  final dragPosition = 0.0.obs;
  final maxDragDistance = 200.0;

  DateTime createdAt = DateTime.now();

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    if (args is String) {
      scanCode.value = args;
      loadExistingData();
    }

    everAll([selectedLoadTypes, loadQuantity, packerComments], (_) {
      isValid.value = selectedLoadTypes.isNotEmpty && loadQuantity.value > 0 && packerComments.value.isNotEmpty;
    });
  }

  final scanCode = ''.obs;

  String formatDateTime(DateTime dateTime) => DateFormat("dd MMM yy HH:mm").format(dateTime);

  Future<void> loadExistingData() async {
    isLoading.value = true;
    try {
      final packingInfo = await getPackingInfoUseCase.execute(scanCode.value);
      if (packingInfo != null) {
        selectedLoadTypes.assignAll(packingInfo.loadTypes);
        loadQuantity.value = packingInfo.loadQuantity;
        packerComments.value = packingInfo.packerComments ?? '';
        photoUrls.assignAll(packingInfo.photoUrls);
        createdAt = packingInfo.createdAt;
        isDataSaved.value = true;
      } else {
        _resetData();
      }
    } catch (e) {
      Get.log('Error loading data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _resetData() {
    selectedLoadTypes.clear();
    loadQuantity.value = 1;
    packerComments.value = '';
    photoUrls.clear();
    createdAt = DateTime.now();
    isDataSaved.value = false;
  }


  void setLoadQuantity(int quantity) {
    if (quantity > 0) {
      loadQuantity.value = quantity;
    }
  }

  void setPackerComments(String comments) => packerComments.value = comments;

  void navigateToScanPage() {
    Get.offAndToNamed(RoutesPaths.scan);
  }

  Future<void> addPhoto({ImageSource source = ImageSource.camera}) async {
    if (photoUrls.length >= 5) return;

    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      photoUrls.add(pickedFile.path);
    }
  }

  void removePhoto(int index) {
    if (index >= 0 && index < photoUrls.length) {
      photoUrls.removeAt(index);
    }
  }


  Future<void> _submit() async {
    if (!isValid.value) return;
    isLoading.value = true;
    try {
      final now = DateTime.now();
      final packingInfo = PackingInfo(
        id: const Uuid().v4(),
        scanCode: scanCode.value,
        loadTypes: List<LoadType>.from(selectedLoadTypes),
        loadQuantity: loadQuantity.value,
        packerComments: packerComments.value,
        photoUrls: List<String>.from(photoUrls),
        createdAt: now,
      );

      await savePackingInfoUseCase.execute(packingInfo);
      isDataSaved.value = true;
      createdAt = now;
      Get.offAllNamed(RoutesPaths.home);
      Get.snackbar(
        'Success',
        'Packing Info is saved.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.log('Error saving data: $e');
      Get.snackbar(
        'Error',
        'Failed to submit packing info',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
      dragPosition.value = 0;
    }
  }

  void submitPackingInfo() => _submit();
}
