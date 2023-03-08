import 'package:advance_course/Presentation/order/view_model.dart';
import 'package:advance_course/Presentation/resources/strings_manager.dart';
import 'package:advance_course/Presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../resources/color_manager.dart';

class ImageOrder extends StatelessWidget {
  const ImageOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderViewMode>(
      init: Get.find<OrderViewMode>(),
      builder: (controller) => Scaffold(
          appBar: AppBar(
            title: Text(
              "Add Order",
              style: StylesManager().getMediumStyle(fontSize: 16.sp),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 50.h),
            child: Form(
                key: controller.formKey,
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: controller.nameCNTL,
                          validator: (value) {
                            if (value!.trim().isEmpty || value.trim() == null) {
                              return AppStrings.validateName.tr;
                            }
                          },
                          decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.person,
                              ),
                              border: InputBorder.none,
                              hintText: AppStrings.name.tr),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        TextFormField(
                          controller: controller.phoneCNTL,
                          validator: (value) {
                            if (value!.trim().isEmpty || value.trim() == null) {
                              return AppStrings.validateNumber.tr;
                            }
                          },
                          decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.phone,
                              ),
                              border: InputBorder.none,
                              hintText: AppStrings.phone.tr),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        TextFormField(
                          controller: controller.medicineNameCNTL,
                          validator: (value) {
                            if (value!.trim().isEmpty || value.trim() == null) {
                              return 'Please Enter Medicine Name';
                            }
                          },
                          decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.medication,
                              ),
                              border: InputBorder.none,
                              hintText: 'Medidicne Name'),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),

                        //________________________________ Change betwen Camera and Gallery_______________________

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '  Upload image',
                              style: StylesManager()
                                  .getMediumStyle(fontSize: 14.sp),
                            ),
                            IconButton(
                              icon: CircleAvatar(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: const Icon(
                                  Icons.camera_alt,
                                  size: 31,
                                ),
                              ),
                              onPressed: () async {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          leading: const Icon(
                                            Icons.camera_alt,
                                          ),
                                          title: Text(
                                            'Camera',
                                            style: StylesManager()
                                                .getMediumStyle(
                                                    fontSize: 14.sp),
                                          ),
                                          onTap: () {
                                            controller
                                                .pickImages(ImageSource.camera);
                                          },
                                        ),
                                        ListTile(
                                          leading: const Icon(
                                            Icons.image,
                                          ),
                                          title: Text(
                                            'Gallery',
                                            style: StylesManager()
                                                .getMediumStyle(
                                                    fontSize: 14.sp),
                                          ),
                                          onTap: () {
                                            controller.pickImages(
                                                ImageSource.gallery);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 2,
                          color: Theme.of(context)
                              .primaryColorDark
                              .withOpacity(0.7),
                        ),
                        Text(
                          controller.imagePath == null
                              ? ''
                              : controller.imagePath.toString(),
                          style: StylesManager().getMediumStyle(fontSize: 9.sp),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundedLoadingButton(
                                loaderSize: 30,
                                loaderStrokeWidth: 5,
                                borderRadius: 30,
                                color: ColorManager.primary,
                                elevation: 10,
                                controller: controller.buttonCNTL,
                                onPressed: () async {
                                  if (controller.formKey.currentState!
                                      .validate()) {
                                    if (controller.image != null) {
                                      controller.addOrder();
                                    } else {
                                      controller.buttonCNTL.reset();
                                    }
                                  } else {
                                    controller.buttonCNTL.reset();
                                  }
                                },
                                child: const Text(
                                  "Submit",
                                  textScaleFactor: 1,
                                ))
                          ],
                        ),
                      ]),
                )),
          )),
    );
  }
}
