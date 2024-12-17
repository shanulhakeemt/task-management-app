import 'dart:ui';

import 'package:get/get.dart';
import 'package:getx_task/core/common/controlers/current_user_controller.dart';
import 'package:getx_task/core/model/user_model.dart';
import 'package:getx_task/features/auth/repository/auth_repository.dart';
import 'package:getx_task/features/auth/view/pages/login_page.dart';
import 'package:getx_task/features/home/view/pages/screen_home.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  Rx<bool> isLoading = false.obs;

  Future<void> signUpUser(
      {required String email,
      required String password,
      required String name}) async {
    isLoading.value = true;
    isLoading.refresh();
    final res = await AuthRepositry.instance
        .signUpUser(email: email, password: password);
    isLoading.value = false;
    isLoading.refresh();
    res.fold(
      (l) => Get.showSnackbar(GetSnackBar(
        duration: const Duration(seconds: 2),
        message: l.message,
        backgroundColor: const Color(0xff003161),
      )),
      (r) async {
        if (r == null) {
          Get.showSnackbar(const GetSnackBar(
            backgroundColor: const Color(0xff003161),
            duration: Duration(seconds: 2),
            message: "Something went wrong",
          ));
        } else {
          Get.offAll(() {
            return const LoginPage();
          });
          Get.showSnackbar(const GetSnackBar(
            duration: Duration(seconds: 2),
            message: "User registered Succesfully,Please login..",
            backgroundColor: Color(0xff003161),
          ));

          await AuthRepositry.instance.addUser(UserModel(
              id: r,
              name: name,
              email: email,
              password: password,
              categories: []));
        }
      },
    );
  }

  Future<void> loginUser(
      {required String email, required String password}) async {
    final res = await AuthRepositry.instance
        .loginUser(email: email, password: password);
    res.fold(
      (l) {
        return Get.showSnackbar(GetSnackBar(
          duration: const Duration(seconds: 2),
          message: l.message,
        ));
      },
      (userModel) async {
        if (userModel == null) {
          Get.showSnackbar(const GetSnackBar(
            duration: Duration(seconds: 2),
            message: "Something went wrong",
          ));
        } else {
          Get.find<CurrentUserController>().updateUserModel(userModel);
          Get.offAll(() {
            return const ScreenHome();
          });
          Get.showSnackbar(const GetSnackBar(
            duration: Duration(seconds: 2),
            message: "User logged Succesfully",
          ));
        }
      },
    );
  }

  Future<void> logout() async {
    await AuthRepositry.instance.logout();
  }
}
