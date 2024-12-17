import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:getx_task/core/constants/firebase_constants.dart';
import 'package:getx_task/core/failure/app_failure.dart';
import 'package:getx_task/core/model/user_model.dart';
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
      final DocumentReference ref = _users.doc(userModel.id);
      return right(await _users
          .doc(userModel.id)
          .set((userModel.copyWith(reference: ref)).toMap()));
    } on FirebaseAuthException catch (e) {
      return left(AppFailure(e.message ?? ""));
    } catch (e) {
      return left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, UserModel?>> loginUser(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      return right((await getUserModel(firebaseUser.value?.uid)));
    } on FirebaseAuthException catch (e) {
      return left(AppFailure(e.message ?? ""));
    } catch (e) {
      return left(AppFailure(e.toString()));
    }
  }

  Future<UserModel?> getUserModel(String? uid) async {
    if (uid == null) {
      return null;
    }
    final user = await _users.doc(uid).get();

    if (user.exists) {
      return UserModel.fromMap(user.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<Either<AppFailure, void>> logout() async {
    try {
      return right(await _auth.signOut());
    } catch (e) {
      return left(AppFailure(e.toString()));
    }
  }
}
