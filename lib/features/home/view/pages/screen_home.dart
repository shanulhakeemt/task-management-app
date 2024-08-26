import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_task/core/common/widgets/loader.dart';
import 'package:getx_task/features/auth/controller/auth_controller.dart';
import 'package:getx_task/features/home/controller/home_controller.dart';
import 'package:getx_task/features/home/model/products_model.dart';
import 'package:getx_task/features/home/view/pages/addorEdit_product.dart';
import 'package:getx_task/features/home/view/widgets/custom_products.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Get.put(HomeController()).getAllProductsModels();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    final HomeController homeController = Get.put(HomeController());

    return Obx(() => authController.isLoading.value
        ? const Loader()
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                "All Products ",
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Get.put(AuthController()).logout();
                    },
                    icon: const Icon(Icons.logout))
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Get.to(() => const ScreenAddEdit(
                  index: -1,
                      isEdit: false,
                    ));
              },
              child: const Icon(Icons.add),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: GetBuilder<HomeController>(
                builder: (controller) {
                  final products = controller.productModels;
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: CustomUserCard(
                        index: index,
                        productModel: products[index],
                      ),
                    ),
                  );
                },
              ),
            ),
          ));
  }
}
