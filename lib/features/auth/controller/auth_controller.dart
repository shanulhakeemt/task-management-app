import 'package:get/get.dart';
import 'package:getx_task/features/auth/model/user_model.dart';
import 'package:getx_task/features/auth/repository/auth_repository.dart';
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
      )),
      (r) async {
        if (r == null) {
          Get.showSnackbar(const GetSnackBar(
            duration: Duration(seconds: 2),
            message: "Something went wrong",
          ));
        } else {
          Get.offAll(() {
            return const ScreenHome();
          });
          Get.showSnackbar(const GetSnackBar(
            duration: Duration(seconds: 2),
            message: "User registered Succesfully",
          ));

          await AuthRepositry.instance.addUser(
              UserModel(id: r, name: name, email: email, password: password));
        }
      },
    );
  }

  Future<void> loginUser(
      {required String email, required String password}) async {
    final res = await AuthRepositry.instance
        .loginUser(email: email, password: password);
    res.fold(
      (l) => Get.showSnackbar(GetSnackBar(
        duration: const Duration(seconds: 2),
        message: l.message,
      )),
      (r) async {
        if (r == null) {
          Get.showSnackbar(const GetSnackBar(
            duration: Duration(seconds: 2),
            message: "Something went wrong",
          ));
        } else {
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
