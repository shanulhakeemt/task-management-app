import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:getx_task/core/constants/firebase_constants.dart';
import 'package:getx_task/core/failure/app_failure.dart';
import 'package:getx_task/core/model/user_model.dart';

class HomeRepository extends GetxController {
  static HomeRepository get instance => Get.find();

  final _firestore = FirebaseFirestore.instance;
  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  Future<Either<AppFailure, void>> addCategory(UserModel userModel) async {
    try {


      await userModel.reference!.update(userModel.toMap());
      return right(null);
    } catch (e) {
      return left(AppFailure(e.toString()));
    }
  }
}
