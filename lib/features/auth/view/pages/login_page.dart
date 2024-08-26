import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_task/core/theme/app_pallete.dart';
import 'package:getx_task/features/auth/controller/auth_controller.dart';
import 'package:getx_task/features/auth/view/pages/signup_page.dart';
import 'package:getx_task/features/auth/view/widgets/auth_button.dart';
import 'package:getx_task/features/auth/view/widgets/custom_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign In.",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomField(
                controller: emailController,
                hintText: "Email",
              ),
              const SizedBox(
                height: 15,
              ),
              CustomField(
                controller: passController,
                isObscuredText: true,
                hintText: "PassWord",
              ),
              const SizedBox(
                height: 20,
              ),
              AuthButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await Get.put(AuthController()).loginUser(
                        email: emailController.text.trim(),
                        password: passController.text.trim());
                  }
                },
                buttonText: "Sign in",
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupPage(),
                      ));
                },
                child: RichText(
                  text: TextSpan(
                      text: "Don't have an account? ",
                      style: Theme.of(context).textTheme.titleMedium,
                      children: const [
                        TextSpan(
                            text: "Sign Up",
                            style: TextStyle(
                                color: Pallete.gradient2,
                                fontWeight: FontWeight.bold))
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
