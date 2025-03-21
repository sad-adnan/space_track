import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:space_track/core/pallets.dart';

import '../../../core/app_styles.dart';
import '../../../domain/entities/packing_info.dart';
import '../../../generated/assets.dart';
import '../controllers/packing_info_controller.dart';
import '../widgets/custom_bottomsheet_content.dart';
import '../widgets/custom_slider_button.dart';
import '../widgets/section_container.dart';

class PackingInfoPage extends StatelessWidget {
  const PackingInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PackingInfoController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Packing Info',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Pallets.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionContainer(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Scan Code',
                                    style: AppStyles.labelStyle),
                                const SizedBox(height: 4),
                                Text(controller.scanCode.value,
                                    style: AppStyles.valueStyle),
                              ],
                            ),
                            IconButton(
                              icon: Image.asset(
                                Assets.pngScan,
                                height: 20,
                                width: 20,
                                color: Colors.black,
                              ),
                              onPressed: () => controller.navigateToScanPage(),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: AppStyles.sectionPadding,
                        color: Colors.grey.shade200,
                        width: Get.width,
                        child: Obx(() {
                          return Row(
                            children: [
                              const Text('PACKING INFO',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black)),
                              const Spacer(),
                              if (controller.isDataSaved.value)
                                Text(
                                  'Submitted: ${controller.formatDateTime(controller.createdAt)}',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Pallets.submittedTextColor),
                                ),
                            ],
                          );
                        }),
                      ),
                      SectionContainer(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Load type',
                                      style: AppStyles.labelStyle),
                                  const SizedBox(height: 4),
                                  Text(
                                    controller.selectedLoadTypes.isEmpty
                                        ? 'Select load types'
                                        : controller.selectedLoadTypes
                                            .map((e) =>
                                                e.toString().split('.').last)
                                            .join(', '),
                                    style: AppStyles.valueStyle,
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: !controller.isDataSaved.value,
                              child: GestureDetector(
                                onTap: () => _showLoadTypeBottomSheet(
                                    context, controller),
                                child: const Text(
                                  'Select',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Pallets.primaryColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SectionContainer(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Load Qty',
                                      style: AppStyles.labelStyle),
                                  const SizedBox(height: 4),
                                  Text(controller.loadQuantity.toString(),
                                      style: AppStyles.valueStyle),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: !controller.isDataSaved.value,
                              child: GestureDetector(
                                onTap: () => _showQuantityBottomSheet(
                                    context, controller),
                                child: const Text(
                                  'Edit',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Pallets.primaryColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SectionContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Packer Comments *',
                                    style: AppStyles.labelStyle),
                                Visibility(
                                  visible: !controller.isDataSaved.value,
                                  child: GestureDetector(
                                    onTap: () => _showCommentsBottomSheet(
                                        context, controller),
                                    child: const Text(
                                      'Edit',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Pallets.primaryColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            if (controller.packerComments.value.isNotEmpty)
                              Text(controller.packerComments.value,
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black))
                            else
                              const Text('No comments yet.',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black54)),
                          ],
                        ),
                      ),
                      Container(
                        padding: AppStyles.sectionPadding,
                        color: Colors.grey.shade200,
                        width: Get.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'PACKING PHOTOS${controller.isDataSaved.value ? "" : " (Max 5)"}',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black),
                            ),
                            Visibility(
                              visible: !controller.isDataSaved.value,
                              child: GestureDetector(
                                onTap: () => controller.addPhoto(
                                    source: ImageSource.gallery),
                                child: const Text(
                                  '+Gallery',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Pallets.primaryColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: AppStyles.sectionPadding,
                        width: Get.width,
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            ...controller.photoUrls
                                .asMap()
                                .entries
                                .map((entry) {
                              final index = entry.key;
                              final url = entry.value;
                              return Stack(
                                children: [
                                  Container(
                                    width: 105,
                                    height: 105,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 0.5),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Padding(
                                        padding: const EdgeInsets.all(
                                            4), // This creates spacing
                                        child: Image.file(
                                          File(url),
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (!controller.isDataSaved.value)
                                    Positioned(
                                      top: -2,
                                      right: -2,
                                      child: GestureDetector(
                                        onTap: () =>
                                            controller.removePhoto(index),
                                        child: Container(
                                          padding: const EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Colors.grey, width: 0.5),
                                          ),
                                          child: const Icon(Icons.close,
                                              size: 16, color: Colors.black),
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            }).toList(),
                            if (controller.photoUrls.length < 5 &&
                                !controller.isDataSaved.value)
                              GestureDetector(
                                onTap: () => controller.addPhoto(),
                                child: DottedBorder(
                                  color: Colors.grey,
                                  dashPattern: const [4, 4],
                                  strokeWidth: 1,
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(4),
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    child: const Center(
                                      child: Icon(Icons.camera_alt,
                                          color: Colors.grey, size: 32),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (!controller.isDataSaved.value)
                Container(
                  padding: AppStyles.sectionPadding,
                  decoration: const BoxDecoration(
                    border:
                        Border(top: BorderSide(color: Colors.grey, width: 0.5)),
                    color: Colors.white,
                  ),
                  child: Obx(() {
                    final isValid = controller.isValid.value;
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        return CustomSliderButton(
                          width: constraints.maxWidth,
                          height: 60,
                          enabled: isValid,
                          text: 'Submit',
                          onSlideComplete: () {
                            if (isValid) {
                              controller.submitPackingInfo();
                            }
                          },
                        );
                      },
                    );
                  }),
                ),
            ],
          );
        }),
      ),
    );
  }

  void _showLoadTypeBottomSheet(
      BuildContext context, PackingInfoController controller) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        List<LoadType> tempSelectedLoadTypes =
            List.from(controller.selectedLoadTypes);
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return CustomBottomSheetContent(
              title: 'Select Load Types',
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: LoadType.values.map((type) {
                  final typeName = type.toString().split('.').last;
                  final isSelected = tempSelectedLoadTypes.contains(type);
                  return CheckboxListTile(
                    title: Text(typeName),
                    value: isSelected,
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          tempSelectedLoadTypes.add(type);
                        } else {
                          tempSelectedLoadTypes.remove(type);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    controller.selectedLoadTypes
                        .assignAll(tempSelectedLoadTypes);
                    Navigator.pop(ctx);
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showQuantityBottomSheet(
      BuildContext context, PackingInfoController controller) {
    final textController =
        TextEditingController(text: controller.loadQuantity.toString());
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      isScrollControlled: true,
      builder: (ctx) {
        return CustomBottomSheetContent(
          title: 'Enter Load Quantity',
          content: TextField(
            controller: textController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Quantity',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(color: Pallets.primaryColor, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(color: Pallets.primaryColor, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(color: Pallets.primaryColor, width: 2.0),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            AppStyles.bottomSheetActionsSpacing,
            TextButton(
              onPressed: () {
                final quantity = int.tryParse(textController.text) ?? 0;
                if (quantity > 0) {
                  controller.setLoadQuantity(quantity);
                }
                Navigator.pop(ctx);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showCommentsBottomSheet(
      BuildContext context, PackingInfoController controller) {
    final textController =
        TextEditingController(text: controller.packerComments.value);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      isScrollControlled: true,
      builder: (ctx) {
        return CustomBottomSheetContent(
          title: 'Enter Packer Comments',
          content: TextField(
            controller: textController,
            maxLines: 5,
            decoration: const InputDecoration(
              labelText: 'Comments',
              alignLabelWithHint: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(color: Pallets.primaryColor, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(color: Pallets.primaryColor, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(color: Pallets.primaryColor, width: 2.0),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            AppStyles.bottomSheetActionsSpacing,
            TextButton(
              onPressed: () {
                controller.setPackerComments(textController.text);
                Navigator.pop(ctx);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
