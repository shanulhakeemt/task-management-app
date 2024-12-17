import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getx_task/core/constants/asset_constants.dart';
import 'package:getx_task/core/constants/list_constants.dart';
import 'package:getx_task/core/theme/app_pallete.dart';
import 'package:getx_task/core/variables/variables.dart';
import 'package:getx_task/features/home/model/products_model.dart';
import 'package:getx_task/features/home/view/pages/add_category.dart';
import 'package:getx_task/features/home/view/pages/tasks_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomUserCard extends StatelessWidget {
  const CustomUserCard(
      {super.key, required this.index, required this.categoryModel});

  final int index;
  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return GestureDetector(
        onTap: () {
          Get.to(() => CategoryPage(
                inx: index,
                categoryModel: categoryModel,
              ));
        },
        child: Container(
            decoration: BoxDecoration(
                color: Pallete.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.2), // Black shadow with opacity
                    blurRadius: 2, // How blurry the shadow is
                    offset:
                        const Offset(1, 1), // Horizontal and vertical offset
                  ),
                ],
                borderRadius: BorderRadius.circular(2)),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: w * .03, vertical: h * .03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    ListConstants.emojiList[categoryModel.iconNumber],
                    style: TextStyle(fontSize: w * .08),
                  ),
                  Text(
                    categoryModel.name,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: w * .033,
                        color: Colors.black),
                  ),
                  Text(
                    "12 tasks",
                    style: GoogleFonts.poppins(
                        fontSize: w * .03, color: Colors.black),
                  ),
                ],
              ),
            )));
  }
}
