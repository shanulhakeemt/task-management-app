import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_task/core/common/controlers/current_user_controller.dart';
import 'package:getx_task/core/common/widgets/loader.dart';
import 'package:getx_task/core/constants/list_constants.dart';
import 'package:getx_task/core/theme/app_pallete.dart';
import 'package:getx_task/core/variables/variables.dart';
import 'package:getx_task/features/auth/view/widgets/custom_field.dart';
import 'package:getx_task/features/home/controller/home_controller.dart';
import 'package:getx_task/features/home/model/products_model.dart';
import 'package:getx_task/features/home/view/widgets/custom_button.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenAddEdit extends StatefulWidget {
  const ScreenAddEdit({super.key, required this.index});

  final int index;

  @override
  State<ScreenAddEdit> createState() => _ScreenAddState();
}

class _ScreenAddState extends State<ScreenAddEdit> {
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: h * .02,
              ),
              Text(
                "Create +",
                style: GoogleFonts.poppins(fontSize: w * .1),
              ),
              SizedBox(
                height: h * .02,
              ),
              CustomField(hintText: "Name", controller: nameController),
              SizedBox(
                height: h * .03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '(Optionel)',
                    style: GoogleFonts.poppins(
                        fontSize: w * .03, fontWeight: FontWeight.w500),
                  ),
                  Obx(() {
                    return Text(
                      ListConstants
                          .emojiList[homeController.selectedEmoji.value],
                      style: GoogleFonts.poppins(
                          fontSize: w * .08, fontWeight: FontWeight.w700),
                    );
                  }),
                ],
              ),
              SizedBox(
                height: h * .02,
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Pallete.whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.2), // Black shadow with opacity
                          blurRadius: 2, // How blurry the shadow is
                          offset: const Offset(
                              1, 1), // Horizontal and vertical offset
                        ),
                      ],
                      borderRadius: BorderRadius.circular(2)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: w * .03, vertical: h * .03),
                    child: Wrap(
                      runSpacing: h * .02,
                      spacing: w * .03,
                      children: List.generate(
                        ListConstants.emojiList.length,
                        (index) => GestureDetector(
                          onTap: () {
                            Get.find<HomeController>().updateEmoji(index);
                          },
                          child: Text(
                            ListConstants.emojiList[index],
                            style: TextStyle(
                                fontSize: w * .07, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  )),
              const SizedBox(
                height: 40,
              ),
              GetBuilder<CurrentUserController>(builder: (controller) {
                return Obx(() {
                  return (homeController.isLoading.value)
                      ? const Loader()
                      : CustomButton(
                          height: 50,
                          width: 250,
                          onTap: () async {
                            Get.find<HomeController>().addCategory(
                                userModel: controller.userModel!.copyWith(
                                    categories: controller
                                            .userModel!.categories +
                                        [
                                          CategoryModel(
                                              name: nameController.text.trim(),
                                              delete: false,
                                              iconNumber: homeController
                                                  .selectedEmoji.value,
                                              taskMap: {})
                                        ]));
                            // Get.put(HomeController()).addCategory(
                            //     categoryModel: ProductModel(
                            //         id: "",
                            //         name: nameController.text.trim(),
                            //         price: int.tryParse(priceController.text.trim()) ?? 0,
                            //         delete: false));
                          },
                          text: "Create",
                        );
                });
              })
            ],
          ),
        ),
      ),
    );
  }
}
