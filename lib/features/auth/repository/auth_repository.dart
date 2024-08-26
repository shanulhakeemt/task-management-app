import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:getx_task/core/constants/firebase_constants.dart';
import 'package:getx_task/core/failure/app_failure.dart';
import 'package:getx_task/features/auth/model/user_model.dart';
import 'package:getx_task/features/auth/view/pages/login_page.dart';
import 'package:getx_task/features/home/view/pages/screen_home.dart';

class AuthRepositry extends GetxController {

  static AuthRepositry get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() {
            return const LoginPage();
          })
        : Get.offAll(() {
            return const ScreenHome();
          });
  }

  Future<Either<AppFailure, String?>> signUpUser(
      {required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return right(firebaseUser.value?.uid);
    } on FirebaseAuthException catch (e) {
      return left(AppFailure(e.message ?? ""));
    } catch (e) {
      return left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, void>> addUser(UserModel userModel) async {
    try {
      return right(await _users.doc(userModel.id).set(userModel.toMap()));
    } on FirebaseAuthException catch (e) {
      return left(AppFailure(e.message ?? ""));
    } catch (e) {
      return left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, String?>> loginUser(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      return right(firebaseUser.value?.uid);
    } on FirebaseAuthException catch (e) {
      return left(AppFailure(e.message ?? ""));
    } catch (e) {
      return left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, void>> logout() async {
    try {
      return right(await _auth.signOut());
    } catch (e) {
      return left(AppFailure(e.toString()));
    }
  }
}
