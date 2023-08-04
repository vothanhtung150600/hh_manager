
import 'package:CFM/Model/model.dart';
import 'package:CFM/mongodb/mongodatabase.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

class Moneymodel extends ChangeNotifier{
  MongoDB db = MongoDB();
  List<Reve> listmoney = [];
  List<Datamonth> listmonth = [];
  bool isLoading = false;
  List<Revenue> listdatamore = [];

  Future<void> loaddatamoney() async {
    isLoading = true;
    notifyListeners();
    listmoney = await db.loadmoney();
    isLoading = false;
    notifyListeners();
  }

  Future<void> loaddatamonth() async {
    isLoading = true;
    notifyListeners();
    listmonth = await db.listdatamonth();
    isLoading = false;
    notifyListeners();
  }

  Future<void> refesh() async {
    isLoading = true;
    notifyListeners();
    listmoney = await db.loadmoney();
    listmonth = await db.listdatamonth();
    isLoading = false;
    notifyListeners();
  }
  List<Product> listmoretoday(DateTime dateTime) {
    var today = listmoney.where((element) {
      DateTime datef = DateFormat("yyyy-MM-dd").parseStrict(element.date);
      final date = datef == dateTime;
      return date;
    }).toList();
    var data = today.map((e) => e.data.map((e) => e.product).expand((element) => element.toList())).expand<Product>((element) => element).toList();
    return data;
  }
  List<Reve> listmoretomonth(int month) {
    var today = listmoney.where((element) {
      DateTime datef = DateFormat("yyyy-MM-dd").parseStrict(element.date);
      final date = datef.month == month;
      return date;
    }).toList();
    var data = today.toList();
    return data;
  }
  List<Reve> revemonth(DateTime dateTime) {
    var today = listmoney.where((element) {
      DateTime datef = DateFormat("yyyy-MM-dd").parseStrict(element.date);
      final date = datef.year == dateTime.year;
      return date;
    }).toList();
    var data = today.toList();
    return data;
  }

  List<Reve> reveday() {
    var now = new DateTime.now();
    var curentime = new DateTime(now.year,now.month,now.day);
    var today = listmoney.where((element) {
      DateTime datef = DateFormat("yyyy-MM-dd").parseStrict(element.date);
      final date =  (datef.day < curentime.day);
      print(datef.day);
      print(date);
      return date;
    }).toList();
    var data = today.toList();
    return data;
  }


  double moneytoday() {
    var now = new DateTime.now();
    var curentime = new DateTime(now.year,now.month,now.day);
    var today = listmoney.where((element) {
      DateTime datef = DateFormat("yyyy-MM-dd").parseStrict(element.date);
      final date = datef == curentime;
      return date;
    }).toList();
    var data = today.map((e) => e.data.map((e) => e.money)).expand<double>((element) => element).sum;
    return data;
  }

  int sumquantity(DateTime dateTime) {
    var today = listmoney.where((element) {
      DateTime datef = DateFormat("yyyy-MM-dd").parseStrict(element.date);
      final date = datef == dateTime;
      return date;
    }).toList();
    var data = today.map((e) => e.data.map((e) => e.product)
        .expand((element) => element.where((el) => el.quantity != 0)))
        .expand<Product>((ee) => ee).toList().map<int>((ell) => ell.quantity ?? 0).toList().sum;
    return data;
  }

  double moneymonth(int month) {
    var now = new DateTime.now();
    var curentime = new DateTime(now.year,now.month,now.day);
    var today = listmoney.where((element) {
      DateTime datef = DateFormat("yyyy-MM-dd").parseStrict(element.date);
      final date = datef.month == month;
      return date;
    }).toList();
    var data = today.map((e) => e.data.map((e) => e.money)).expand<double>((element) => element).sum;
    return data;
  }
}