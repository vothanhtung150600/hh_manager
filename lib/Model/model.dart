import 'package:hive/hive.dart';


class Itembanner {
  String image;
  String name;
  Itembanner(this.image,this.name);
}
List<Itembanner> listdatabanner = [
  Itembanner('assets/product/cafe.png','Nước uống'),
  Itembanner('assets/product/bia.png','Bia'),
  Itembanner('assets/product/lua.png','Thức ăn & Lúa'),
  Itembanner('assets/product/gao.png','Gạo'),
  Itembanner('assets/product/bap_ga.png','Bắp'),
  Itembanner('assets/product/tam.png','Tấm'),
];

class ModelData {
  String? type;
  List<Product>? product;
  ModelData({required this.type,required this.product});

  ModelData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['data'] != null) {
      product = <Product>[];
      json['data'].forEach((v) {
        product!.add(new Product.fromJson(v));
      });
    }
  }
}

class Product {
  String? type;
  String? image;
  String? name;
  int? price;
  int? quantity;
  Product({required this.type,required this.image,required this.name, required this.price,required this.quantity});
  Product.update(this.name,this.price);


  Product.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    image = json['image'];
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['image'] = this.image;
    data['name'] = this.name;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    return data;
  }
}

class Revenue {
  double money;
  DateTime date;
  List<Product> product;

  Revenue({
    required this.money,
    required this.date,
    required this.product,
  });

  factory Revenue.fromJson(Map<String, dynamic> json) => Revenue(
    money: json["money"],
    date: json["date"],
    product: List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "money": money,
    "date" : date,
    "product": List<dynamic>.from(product.map((x) => x.toJson())),
  };
}

class Reve {
  String date;
  List<Revenue> data;

  Reve({
    required this.date,
    required this.data,
  });

  factory Reve.fromJson(Map<String, dynamic> json) => Reve(
    date: json["date"],
    data: List<Revenue>.from(json["data"].map((x) => Revenue.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}


class Datamonth {
  int date;
  List<Revenue> data;

  Datamonth({
    required this.date,
    required this.data,
  });

  factory Datamonth.fromJson(Map<String, dynamic> json) => Datamonth(
    date: json["date"],
    data: List<Revenue>.from(json["data"].map((x) => Revenue.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}