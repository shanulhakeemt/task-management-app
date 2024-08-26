import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_task/features/auth/view/widgets/custom_field.dart';
import 'package:getx_task/features/home/controller/home_controller.dart';
import 'package:getx_task/features/home/model/products_model.dart';
import 'package:getx_task/features/home/view/widgets/custom_button.dart';

class ScreenAddEdit extends StatefulWidget {
  const ScreenAddEdit({super.key, required this.isEdit, this.productModel,required this.index});

  final ProductModel? productModel;
  final bool isEdit;
  final int index;

  @override
  State<ScreenAddEdit> createState() => _ScreenAddState();
}

class _ScreenAddState extends State<ScreenAddEdit> {
  late TextEditingController nameController;
  late TextEditingController priceController;

  @override
  void initState() {
    nameController = TextEditingController(
        text: widget.isEdit ? widget.productModel!.name : "");
    priceController = TextEditingController(
        text: widget.isEdit ? widget.productModel!.price.toString() : "");
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            const Text(
              "Create +",
              style: TextStyle(fontSize: 50),
            ),
            const SizedBox(
              height: 40,
            ),
            CustomField(hintText: "Name", controller: nameController),
            const SizedBox(
              height: 20,
            ),
            CustomField(hintText: "Price", controller: priceController),
            const SizedBox(
              height: 40,
            ),
            CustomButton(
              height: 50,
              width: 250,
              onTap: () async {
                if (widget.isEdit) {
                  Get.put(HomeController()).updateProduct(
                    index: widget.index,
                      productModel: widget.productModel!.copyWith(
                          name: nameController.text.trim(),
                          price: int.tryParse(priceController.text.trim())),
                      isDelete: false);
                } else {
Get.put(HomeController()).addProduct(
                      productModel:ProductModel(id: "", name: nameController.text.trim(), price:int.tryParse(priceController.text.trim())??0, delete: false));


                }
              },
              text: widget.isEdit ? "Edit" : "Create",
            )
          ],
        ),
      ),
    );
  }
}
