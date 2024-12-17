import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_task/core/common/controlers/current_user_controller.dart';
import 'package:getx_task/core/theme/theme.dart';
import 'package:getx_task/features/auth/repository/auth_repository.dart';
import 'package:getx_task/features/home/controller/home_controller.dart';
import 'package:getx_task/features/home/repository/home_repository.dart';
import 'package:getx_task/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then(
    (value) {
      Get.put(AuthRepositry());
      Get.put(CurrentUserController());
      Get.put(HomeRepository());
      Get.put(HomeController());
    },
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.darkThemeMode,
      home: const CircularProgressIndicator(),
    );
  }
}
