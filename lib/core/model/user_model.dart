// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getx_task/features/home/model/products_model.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String password;
  final List<CategoryModel> categories;
  final DocumentReference? reference;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.categories,
    this.reference,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    List<CategoryModel>? categories,
    DocumentReference? reference,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      categories: categories ?? this.categories,
      reference: reference ?? this.reference,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'categories': categories.map((x) => x.toMap()).toList(),
      'reference': reference,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      categories: (map['categories'] as List)
          .map(
            (e) => CategoryModel.fromMap(e),
          )
          .toList(),
      reference: map['reference'],
    );
  }
}
