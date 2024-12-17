import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_task/core/common/controlers/current_user_controller.dart';
import 'package:getx_task/core/common/widgets/loader.dart';
import 'package:getx_task/features/auth/view/widgets/custom_field.dart';
import 'package:getx_task/features/home/controller/home_controller.dart';
import 'package:getx_task/features/home/model/products_model.dart';
import 'package:getx_task/features/home/view/widgets/custom_button.dart';
import 'package:intl/intl.dart';

class AddTasks extends StatefulWidget {
  const AddTasks({super.key, required this.index});
  final int index;

  @override
  // ignore: library_private_types_in_public_api
  _AddTasksState createState() => _AddTasksState();
}

class _AddTasksState extends State<AddTasks> {
  final TextEditingController nameController = TextEditingController();
  DateTime? selectedDate;
  Future<void> _selectedToDate({
    required BuildContext context,
  }) async {
    DateTime? picked;
    picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2030, 12, 1));
    if (picked != null) {
      selectedDate =
          DateTime(picked.year, picked.month, picked.day, 23, 59, 59);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

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
              "Add +",
              style: TextStyle(fontSize: 50),
            ),
            const SizedBox(
              height: 40,
            ),
            CustomField(hintText: "Name", controller: nameController),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              height: 50,
              width: 250,
              text: selectedDate == null
                  ? 'Select the date'
                  : DateFormat('MMM dd yyyy').format(selectedDate!),
              onTap: () {
                _selectedToDate(context: context);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 40,
            ),
            GetBuilder<CurrentUserController>(builder: (controller) {
              return Obx(() {
                return (homeController.isLoading.value)
                    ? const Loader()
                    : CustomButton(
                        height: 50,
                        width: 250,
                        onTap: () async {
                          List<CategoryModel> categories =
                              controller.userModel!.categories;

                          final taskMap = categories[widget.index].taskMap;
                          final Map<String, dynamic> t;

                          if (taskMap.isEmpty) {
                            t = {
                              DateFormat('MMM dd yyyy').format(selectedDate!): [
                                {
                                  'subTaskName': nameController.text.trim(),
                                  'isFinished': false
                                }
                              ]
                            };
                          } else {
                            taskMap[DateFormat('MMM dd yyyy')
                                .format(selectedDate!)] = taskMap[
                                        DateFormat('MMM dd yyyy')
                                            .format(selectedDate!)] ==
                                    null
                                ? [
                                    {
                                      'subTaskName': nameController.text.trim(),
                                      'isFinished': false
                                    }
                                  ]
                                : [
                                    ...taskMap[DateFormat('MMM dd yyyy')
                                        .format(selectedDate!)],
                                    {
                                      'subTaskName': nameController.text.trim(),
                                      'isFinished': false
                                    }
                                  ];
                            t = taskMap;
                          }

                          print(":::::::::::::::::");
                          print(t);
                          print(":::::::::::::::::");

                          final tas =
                              categories[widget.index]!.copyWith(taskMap: t);
                          categories[widget.index] = tas;
                          print(categories[0].toMap());
                          Get.find<HomeController>().addCategory(
                              userModel: controller.userModel!
                                  .copyWith(categories: categories));
                        },
                        text: "Create",
                      );
              });
            })
          ],
        ),
      ),
    );
  }
}
