import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:getx_task/core/theme/app_pallete.dart';
import 'package:getx_task/features/home/model/products_model.dart';
import 'package:getx_task/features/home/repository/home_repository.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  List<ProductModel> productModels = [];

  @override
  Future<void> onReady() async {
    //  productModels = await HomeRepository.instance.getProductModels();
  }

  Future<void> getAllProductsModels() async {
    productModels = await Get.put(HomeRepository()).getProductModels();
    update();
  }

  Future<void> addProduct({required ProductModel productModel}) async {
      productModels.add(productModel);
        update();
        Get.back();

        Get.snackbar("Succesfully added the product",
            "Please check the product list..., ",
            animationDuration: const Duration(seconds: 1),
            colorText: Pallete.backgroundColor,
            duration: const Duration(seconds: 2),
            backgroundColor: Pallete.whiteColor);
    final res =
        await HomeRepository.instance.addProduct(productModel: productModel);
    res.fold(
      (l) => null,
      (r) {
        // productModels.add(productModel);
        // update();
        // Get.back();

        // Get.snackbar("Succesfully added the product",
        //     "Please check the product list..., ",
        //     animationDuration: const Duration(seconds: 1),
        //     colorText: Pallete.backgroundColor,
        //     duration: const Duration(seconds: 2),
        //     backgroundColor: Pallete.whiteColor);
      },
    );
  }

  Future<void> updateProduct(
      {required ProductModel productModel,
      required bool isDelete,
      required int index}) async {
    if (isDelete) {
      productModels.removeAt(index);
    } else {
      productModels[index] = productModel;
    
    }
          update();

    final res =
        await HomeRepository.instance.updateProduct(productModel: productModel);
    res.fold(
      (l) => null,
      (r) {
        Get.back();

        Get.snackbar(
            animationDuration: const Duration(seconds: 1),
            isDelete
                ? "Succesfully deleted the product"
                : "Succesfully Edited the product",
            "check the list..,",
            colorText: Pallete.backgroundColor,
            backgroundColor: Pallete.whiteColor,
            duration: const Duration(seconds: 2));
      },
    );
  }

  Stream<List<ProductModel>> getAllProducts() {
    return Get.put(HomeRepository()).getAllProducts();
  }
}
