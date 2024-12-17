import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_task/core/common/controlers/current_user_controller.dart';
import 'package:getx_task/core/common/widgets/loader.dart';
import 'package:getx_task/core/constants/asset_constants.dart';
import 'package:getx_task/core/theme/app_pallete.dart';
import 'package:getx_task/core/variables/variables.dart';
import 'package:getx_task/features/auth/controller/auth_controller.dart';
import 'package:getx_task/features/home/controller/home_controller.dart';
import 'package:getx_task/features/home/model/products_model.dart';
import 'package:getx_task/features/home/view/pages/add_category.dart';
import 'package:getx_task/features/home/view/widgets/custom_products.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;

    return Obx(() => authController.isLoading.value
        ? const Loader()
        : Scaffold(
            appBar: AppBar(
              leading: Padding(
                padding: EdgeInsets.only(left: w * .02),
                child: CircleAvatar(
                  radius: w * .02,
                  backgroundColor: Pallete.whiteColor,
                  backgroundImage: const AssetImage(
                    AssetConstants.profileImage1,
                  ),
                ),
              ),
              centerTitle: true,
              title: const Text(
                "Categories",
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Get.put(AuthController()).logout();
                    },
                    icon: const Icon(CupertinoIcons.search))
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: w * .04),
              child: Column(
                children: [
                  SizedBox(
                    height: h * .02,
                  ),
                  Container(
                    height: h * .12,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          radius: w * .05,
                          backgroundColor: Pallete.whiteColor,
                          backgroundImage: const AssetImage(
                            AssetConstants.profileImage2,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              " \"The memories is a shield & life helper\"",
                              style: GoogleFonts.berkshireSwash(
                                  fontSize: w * .041,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "  Tamim Al-Barghoti",
                              style: GoogleFonts.poppins(
                                  fontSize: w * .026, color: Colors.black54),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: h * .02,
                  ),
                  Expanded(
                    child: GetBuilder<CurrentUserController>(
                      init: CurrentUserController(),
                      builder: (controller) {
                        if (controller.userModel == null) {
                          return const Loader();
                        }
                        final categories = controller.userModel?.categories;

                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Number of items per row
                            crossAxisSpacing: 10.0, // Horizontal spacing
                            mainAxisSpacing: 10.0, // Vertical spacing
                          ),
                          itemCount:
                              categories!.length + 1, // Total number of items
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return GestureDetector(
                                  onTap: () {
                                    Get.to(() => const ScreenAddEdit(
                                          index: -1,
                                        ));
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Pallete.whiteColor,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                  0.2), // Black shadow with opacity
                                              blurRadius:
                                                  2, // How blurry the shadow is
                                              offset: const Offset(1,
                                                  1), // Horizontal and vertical offset
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: w * .03,
                                              vertical: h * .03),
                                          child: Center(
                                              child: CircleAvatar(
                                            backgroundColor:
                                                Pallete.secondoryColor,
                                            radius: w * .1,
                                            child: Icon(
                                              Icons.add,
                                              size: w * .09,
                                              color: Pallete.whiteColor,
                                            ),
                                          )))));
                            }
                            return CustomUserCard(
                              index: index-1,
                              categoryModel: categories[index - 1],
                            );
                          },
                          padding: const EdgeInsets.all(
                              10.0), // Optional padding around the grid
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ));
  }
}
