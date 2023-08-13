
import 'package:CFM/Model/model.dart';
import 'package:CFM/mongodb/mongodatabase.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

class Homemodel extends ChangeNotifier{
  MongoDB db = MongoDB();
  List<ModelData> listmodel = [];
  bool isLoading = true;
  Future<void> loaddata() async {
    listmodel = await db.connect();
    isLoading = false;
    notifyListeners();
  }

  Future<void> refesh() async {
    isLoading = true;
    notifyListeners();
    listmodel = await db.connect();
    isLoading = false;
    notifyListeners();
  }
  Future<void> clear() async {
    clearproduct();
    notifyListeners();
  }

  void clearproduct()  {
    listmodel.forEach((element) {
      element.product!.forEach((product) {
        product.quantity = 0;
      });
    });
  }

  List<Product> choseproduct()  {
    return listmodel.map((e) => e.product!.where((element) => element.quantity != 0)).expand<Product>((element) => element).toList();
  }

  int sumquantity() {
    return listmodel.map((e) =>
        e.product!.where((element) =>
        element.quantity != 0)).expand<Product>((element) => element)
        .toList().map<int>((e) => e.quantity ?? 0).toList().sum;
  }
  double total()  {
    return listmodel.map((e) =>
        e.product!.where((element) =>
          element.quantity != 0)).expand<Product>((element) => element)
        .toList().map<double>((e) => e.price! * e.quantity! * 1.0).toList().sum;
  }



  bool _isShowAppBar = true;

  bool get isShowAppBar => _isShowAppBar;

  set isShowAppBar(bool value) {
    if(value != isShowAppBar){
      _isShowAppBar = value;
      notifyListeners();
    }
  }

  bool _showBackToTopButton = false;
  bool get showBackToTopButton => _showBackToTopButton;

  set showBackToTopButton(bool value) {
    if(value != _showBackToTopButton){
      _showBackToTopButton = value;
      notifyListeners();
    }
  }
}