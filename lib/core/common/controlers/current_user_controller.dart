import 'package:get/get.dart';
import 'package:getx_task/core/model/user_model.dart';

class CurrentUserController extends GetxController {
  static CurrentUserController get instance => Get.find();

  UserModel? userModel;
  // UserModel? get userModel => _userModel;

  void updateUserModel(UserModel u) {
    print("ooooooooooooooo");
    print(u);
    print("ooooooooooooooo");
    userModel = u;
    update();
  }
}
