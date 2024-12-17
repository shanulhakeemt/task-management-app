class CategoryModel {
  final String name;
  final bool delete;
  final int iconNumber;
  final Map<String, dynamic> taskMap;
  CategoryModel({
    required this.name,
    required this.delete,
    required this.iconNumber,
    required this.taskMap,
  });

  CategoryModel copyWith({
    String? id,
    String? name,
    int? price,
    bool? delete,
    int? iconNumber,
    Map<String, dynamic>? taskMap,
  }) {
    return CategoryModel(
      name: name ?? this.name,
      delete: delete ?? this.delete,
      iconNumber: iconNumber ?? this.iconNumber,
      taskMap: taskMap ?? this.taskMap,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'delete': delete,
      'iconNumber': iconNumber,
      'taskMap': taskMap,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      name: map['name'] ?? '',
      delete: map['delete'] ?? false,
      iconNumber: map['iconNumber'] ?? 0,
      taskMap: map['taskMap'] ?? {},
    );
  }
}


// class SubTasksModel {
//   final String subTaskName;
//   final bool isFinished;
//   SubTasksModel({
//     required this.subTaskName,
//     required this.isFinished,
//   });

//   SubTasksModel copyWith({
//     String? subTaskName,
//     bool? isFinished,
//   }) {
//     return SubTasksModel(
//       subTaskName: subTaskName ?? this.subTaskName,
//       isFinished: isFinished ?? this.isFinished,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'subTaskName': subTaskName,
//       'isFinished': isFinished,
//     };
//   }

//   factory SubTasksModel.fromMap(Map<String, dynamic> map) {
//     return SubTasksModel(
//       subTaskName: map['subTaskName'] ?? '',
//       isFinished: map['isFinished'] ?? false,
//     );
//   }
// }
