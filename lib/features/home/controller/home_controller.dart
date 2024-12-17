import 'dart:ui';

import 'package:get/get.dart';
import 'package:getx_task/core/common/controlers/current_user_controller.dart';
import 'package:getx_task/core/model/user_model.dart';
import 'package:getx_task/core/theme/app_pallete.dart';
import 'package:getx_task/features/home/model/products_model.dart';
import 'package:getx_task/features/home/repository/home_repository.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  List<CategoryModel> productModels = [];
  Rx<bool> isLoading = false.obs;
  Rx<int> selectedEmoji = 0.obs;

  void updateEmoji(int i) {
    selectedEmoji.value = i;
  }

  @override
  Future<void> onReady() async {
    //  productModels = await HomeRepository.instance.getProductModels();
  }

  Future<void> addCategory(
      {required UserModel userModel, bool isPop = true}) async {
    if (isPop) {
      isLoading.value = true;
    }
    final res = await HomeRepository.instance.addCategory(userModel);
    res.fold(
      (l) {
        return isLoading.value = false;
      },
      (r) {
        Get.find<CurrentUserController>().updateUserModel(userModel);
        if (isPop) {
          isLoading.value = false;

          Get.back();
          Get.snackbar("Succesfully added the product",
              "Please check the product list..., ",
              animationDuration: const Duration(seconds: 1),
              colorText: Pallete.backgroundColor,
              duration: const Duration(seconds: 2),
              backgroundColor: const Color(0xff003161));
        }
      },
    );
  }
}
