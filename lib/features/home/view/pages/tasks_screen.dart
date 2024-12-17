import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getx_task/core/common/controlers/current_user_controller.dart';
import 'package:getx_task/core/common/functions.dart';
import 'package:getx_task/core/theme/app_pallete.dart';
import 'package:getx_task/core/variables/variables.dart';
import 'package:getx_task/features/home/controller/home_controller.dart';
import 'package:getx_task/features/home/model/products_model.dart';
import 'package:getx_task/features/home/view/pages/add_tasks.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage(
      {super.key, required this.categoryModel, required this.inx});
  final CategoryModel categoryModel;
  final int inx;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  Map getSortedMap() {
    var sortedEntries = widget.categoryModel.taskMap.entries.toList()
      ..sort((a, b) {
        // Parse the DateTime strings and compare
        DateTime dateA =
            DateTime.parse(monthToDateTime(a.key).toIso8601String());
        DateTime dateB =
            DateTime.parse(monthToDateTime(b.key).toIso8601String());
        return dateA.compareTo(dateB);
      });

    // Create a sorted map (optional)
    Map<String, dynamic> sortedMap = {
      for (var entry in sortedEntries) entry.key: entry.value
    };
    return sortedMap;
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Pallete.secondoryColor,
        shape: const CircleBorder(),
        onPressed: () {
          Get.to(() => AddTasks(
                index: widget.inx,
              ));
        },
        child: const Icon(
          CupertinoIcons.add,
          color: Pallete.whiteColor,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.categoryModel.name,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: h * .03, horizontal: w * .07),
        child: SingleChildScrollView(
          child: Column(
            children: getSortedMap()
                .entries
                .map(
                  (e) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getRelativeDay(e.key),
                        style: GoogleFonts.poppins(
                            fontSize: w * .036,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54),
                      ),
                      SizedBox(
                        height: h * .02,
                      ),
                      ...List.generate(
                        e.value.length,
                        (index) {
                          final m = e.value[index];

                          return Padding(
                            padding: EdgeInsets.only(bottom: h * .02),
                            child: Row(
                              children: [
                                GetBuilder<CurrentUserController>(
                                    builder: (currentUser) {
                                  return GestureDetector(
                                      onTap: () {
                                        if (!checkTheDayIsBeforeToday(e.key)) {
                                          Map<String, dynamic> taskMap =
                                              widget.categoryModel.taskMap;
                                          List l = taskMap[e.key];

                                          final m = {
                                            'subTaskName': taskMap[e.key][index]
                                                ['subTaskName'] as String,
                                            'isFinished': !taskMap[e.key][index]
                                                ['isFinished']
                                          };
                                          l[index] = m;
                                          taskMap[e.key] = l;
                                          List<CategoryModel> cats =
                                              currentUser.userModel!.categories;
                                          final category = widget.categoryModel
                                              .copyWith(taskMap: taskMap);
                                          cats[widget.inx] = category;

                                          setState(() {});
                                          Get.find<CurrentUserController>()
                                              .updateUserModel(currentUser
                                                  .userModel!
                                                  .copyWith(categories: cats));
                                          Get.find<HomeController>()
                                              .addCategory(
                                                  isPop: false,
                                                  userModel:
                                                      currentUser.userModel!);
                                        }
                                      },
                                      child: CircleAvatar(
                                        backgroundColor:
                                            checkTheDayIsBeforeToday(e.key)
                                                ? m['isFinished']
                                                    ? Colors.greenAccent
                                                    : Colors.grey
                                                : m['isFinished']
                                                    ? Colors.green
                                                    : Colors.green.shade100,
                                        radius: w * .05,
                                        child: Icon(
                                          CupertinoIcons.check_mark,
                                          color: Pallete.whiteColor,
                                          size: w * .05,
                                        ),
                                      ));
                                }),
                                SizedBox(
                                  width: w * .07,
                                ),
                                Text(
                                  m['subTaskName'],
                                  style: GoogleFonts.poppins(
                                    fontSize: w * .04,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: h * .01,
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
