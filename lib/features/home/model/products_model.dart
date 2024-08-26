class ProductModel {
  final String id;
  final String name;
  final int price;
  final bool delete;
  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.delete,
  });

  ProductModel copyWith({
    String? id,
    String? name,
    int? price,
    bool? delete,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      delete: delete?? this.delete,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'delete': delete,
      'price': price,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ??"",
      delete: map['delete'] ??false,
      name: map['name']??'',
      price: map['price'] ??0,
    );
  }


  

}
