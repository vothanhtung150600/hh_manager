

import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mongo_dart/mongo_dart.dart';
import "package:collection/collection.dart";
import 'package:intl/intl.dart';
import '../Model/model.dart';


class MongoDB {
  Future<List<ModelData>> connect() async {
    var db = await Db.create(dotenv.env['VAR_NAME']!);
    await db.open();
    inspect(db);
    var collection = db.collection(dotenv.env['COLLECTION_NAME']!);
    List<ModelData> result = [];
    var product = await collection.find().toList();
    if(product != null){
      var listtype = ['Nước giải khát','Bia','Thức ăn & Lúa','Gạo','Bắp','Tấm'];
      var data = listtype.map((type) => {
        "type" : type,
        "data" : product.where((element) => element['type'] == type).toList()
      });
      List<ModelData> listdata = data.map((e) {
        return ModelData.fromJson(e);
      }).toList();
      result.addAll(listdata);
      print("listdata : ${listdata}");
    }
    return result;
  }
  static Future<String> createmoney(Revenue model) async{
    var db = await Db.create(dotenv.env['VAR_NAME']!);
    await db.open();
    inspect(db);
    var collection = db.collection(dotenv.env['COLLECTION_MONEY']!);
    try{
      var result = await collection.insertOne(model.toJson());
      if(result.isSuccess){
        return "Data insert success";
      }else{
        return "Data insert fail";
      }
    }
    catch(e){
      return e.toString();
    }
  }
  static Future<String> updatedata(Product model) async{
    var db = await Db.create(dotenv.env['VAR_NAME']!);
    await db.open();
    inspect(db);
    var collection = db.collection(dotenv.env['COLLECTION_NAME']!);
    try{
      var result = await collection.update(where.eq('name', model.name),modify.set('price', model.price));
      if(result.isNotEmpty){
        return "Data insert success";
      }else{
        return "Data insert fail";
      }
    }
    catch(e){
      return e.toString();
    }
  }

  Future<List<Reve>> loadmoney() async{
    var db = await Db.create(dotenv.env['VAR_NAME']!);
    await db.open();
    inspect(db);
    var collection = db.collection(dotenv.env['COLLECTION_MONEY']!);
    List<Reve> result =  [];
    var money = await collection.find().toList();
    if(money != null){
      var data = groupBy(money, (obj) => DateFormat('yyyy-MM-dd').format(obj['date'])).map((key, value) => MapEntry(key, value.map((e) => {
        'money' : e['money'],
        'date' : e['date'],
        'product' : e['product']
      }).toList()));
      var listdata = data.keys.map((date) => {
        "date" : date,
        "data" : data[date]
      }).toList();
      listdata.sort((a, b) => b['date'].toString().compareTo(a['date'].toString()),);
      List<Reve> list = listdata.map((e) {
        return Reve.fromJson(e);
      }).toList();
      result.addAll(list);
      print("listmoney : ${listdata}");
    }
    return result;
  }
  Future<List<Datamonth>> listdatamonth() async{
    var db = await Db.create(dotenv.env['VAR_NAME']!);
    await db.open();
    inspect(db);
    var collection = db.collection(dotenv.env['COLLECTION_MONEY']!);
    List<Datamonth> result =  [];
    var money = await collection.find().toList();
    if(money != null){
      var data = groupBy(money, (obj) => DateFormat('yyyy-MM-dd').parseUtc(obj['date'].toString()).month).map((key, value) => MapEntry(key, value.map((e) => {
        'money' : e['money'],
        'date' : e['date'],
        'product' : e['product']
      }).toList()));
      var listdata = data.keys.map((date) => {
        "date" : date,
        "data" : data[date]
      }).toList();
      listdata.sort((a, b) => b['date'].toString().compareTo(a['date'].toString()),);
      List<Datamonth> list = listdata.map((e) {
        return Datamonth.fromJson(e);
      }).toList();
      result.addAll(list);
      print("listmoney : ${listdata}");
    }
    return result;
}
}