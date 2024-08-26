import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:getx_task/core/constants/firebase_constants.dart';
import 'package:getx_task/core/failure/app_failure.dart';
import 'package:getx_task/features/home/model/products_model.dart';

class HomeRepository extends GetxController {
  static HomeRepository get instance => Get.find();

  final _firestore = FirebaseFirestore.instance;
  CollectionReference get _products =>
      _firestore.collection(FirebaseConstants.productsCollection);

  Future<Either<AppFailure, void>> addProduct(
      {required ProductModel productModel}) async {
    try {
      await _products.add(productModel.toMap()).then(
        (value) {
          value.update((productModel.copyWith(id: value.id)).toMap());
        },
      );
      return right(null);
    } catch (e) {
      return left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, void>> updateProduct(
      {required ProductModel productModel}) async {
    try {
      await _products.doc(productModel.id).update(productModel.toMap());
      return right(null);
    } catch (e) {
      return left(AppFailure(e.toString()));
    }
  }

  Stream<List<ProductModel>> getAllProducts() {
    return _products.where("delete", isEqualTo: false).snapshots().map(
          (event) => event.docs
              .map(
                (e) => ProductModel.fromMap(e.data() as Map<String, dynamic>),
              )
              .toList(),
        );
  }

  Future<List<ProductModel>> getProductModels() async {
    print("onReady worked");
    List<ProductModel> productModels = [];
    final products = await _products.where("delete", isEqualTo: false).get();

    for (DocumentSnapshot i in products.docs) {
      productModels.add(ProductModel.fromMap(i.data() as Map<String, dynamic>));
    }
    print("data**");
    print(products.docs.first.data());
    print("data**");

    return productModels;
  }
}
