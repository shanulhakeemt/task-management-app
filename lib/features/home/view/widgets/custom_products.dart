import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_task/core/theme/app_pallete.dart';
import 'package:getx_task/features/home/controller/home_controller.dart';
import 'package:getx_task/features/home/model/products_model.dart';
import 'package:getx_task/features/home/view/pages/addorEdit_product.dart';

class CustomUserCard extends StatelessWidget {
  const CustomUserCard({super.key, required this.productModel, required this.index});

  final ProductModel productModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          decoration: BoxDecoration(
              color: Pallete.secondoryColor,
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Name :  ${productModel.name}",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Pallete.whiteColor),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Age     :  ${productModel.price}",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Pallete.whiteColor),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.to(() => ScreenAddEdit(
                            index:index ,
                                isEdit: true,
                                productModel: productModel,
                              ));
                        },
                        icon: const Icon(Icons.edit)),
                    IconButton(
                        onPressed: () {
                          Get.put(HomeController()).updateProduct(
                            index: index,
                              productModel: productModel.copyWith(delete: true),
                              isDelete: true);
                        },
                        icon: const Icon(Icons.delete)),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
