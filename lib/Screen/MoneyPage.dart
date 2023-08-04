import 'dart:ui';
import 'package:CFM/Model/provider_money.dart';
import 'package:CFM/Screen/More/more_money.dart';
import 'package:CFM/Screen/More/more_month.dart';
import 'package:CFM/Screen/More/more_revemonth.dart';
import 'package:CFM/Screen/Orderpage.dart';
import 'package:CFM/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive/hive.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../Login/signin_screen.dart';
import '../Model/model.dart';
import '../Model/provider_model.dart';
import '../dialog/showdialog.dart';
import 'package:intl/intl.dart';

import '../utils/loading_widget.dart';
import 'More/more_reveday.dart';



class MoneyPage extends StatefulWidget {
  const MoneyPage({Key? key}) : super(key: key);

  @override
  State<MoneyPage> createState() => _MoneyPageState();
}

class _MoneyPageState extends State<MoneyPage> {
  final _scrollController = ScrollController();
  final formatter = NumberFormat('###,###,###');
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Moneymodel model = Provider.of<Moneymodel>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 60,
          backgroundColor: Colors.white,
          title: Text('Huỳnh Hằng Coffee',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.pinkAccent,fontSize: 24),),
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/logoscreen.jpg'),
                    fit: BoxFit.cover),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                child: Container(
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ),
            RefreshIndicator(
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                child: Skeletonizer(
                  enabled: model.isLoading,
                  child: model.isLoading ?
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green.withOpacity(0.4)
                        ),
                        height: 130,
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 10,left: 5,right: 5),
                        child: Container(
                          margin: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Doanh thu Tháng ${DateTime.now().month}: ',style: TextStyle(fontSize: 20),),
                                  Container(
                                    child: Text('${DateTime.now().month}/${DateTime.now().year}',style: TextStyle(fontSize: 18),),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('${formatter.format(num.parse(model.moneymonth(DateTime.now().month).toString()))}',style: TextStyle(fontSize: 25),),
                                  SizedBox(width: 10,),
                                  Text('VND',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700),),

                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap:(){
                                      var now = new DateTime.now();
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => MoreMonth(month: now.month),));
                                    },
                                    child: Container(
                                      child: Text('Xem chi tiết',style: TextStyle(fontSize: 18,color: Colors.blue),),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.pinkAccent.withOpacity(0.4)
                        ),
                        height: 150,
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 20,left: 5,right: 5),
                        child: Container(
                          margin: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Doanh thu hôm nay: ',style: TextStyle(fontSize: 20),),
                                  Container(
                                    child: Text('${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',style: TextStyle(fontSize: 18),),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('${formatter.format(num.parse(model.moneytoday().toString()))}',style: TextStyle(fontSize: 25),),
                                  SizedBox(width: 10,),
                                  Text('VND',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700),),
                                ],
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap:(){
                                      var now = new DateTime.now();
                                      var curentime = new DateTime(now.year,now.month,now.day);
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => MoreMoney(dateTime: curentime,money: model.moneytoday()),));
                                    },
                                    child: Container(
                                      child: Text('Xem chi tiết',style: TextStyle(fontSize: 18,color: Colors.blue),),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          var now = new DateTime.now();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ReveDay(),));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 20,left: 5,right: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.pinkAccent
                          ),
                          height: 60,
                          width: double.infinity,
                          child: Container(
                            margin: EdgeInsets.only(left: 10,right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Doanh thu các ngày trước',style: TextStyle(fontSize: 20,color: Colors.white),),
                                Icon(Icons.navigate_next,size: 35,color: Colors.white,)
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          var now = new DateTime.now();
                          var curentime = new DateTime(now.year,now.month,now.day);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ReveMonth(dateTime: curentime),));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 20,left: 5,right: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.pinkAccent
                          ),
                          height: 60,
                          width: double.infinity,
                          child: Container(
                            margin: EdgeInsets.only(left: 10,right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Doanh thu các Tháng',style: TextStyle(fontSize: 20,color: Colors.white),),
                                Icon(Icons.navigate_next,size: 35,color: Colors.white,)
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen(),));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 20,left: 5,right: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.pinkAccent
                          ),
                          height: 60,
                          width: double.infinity,
                          child: Container(
                            margin: EdgeInsets.only(left: 10,right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Chỉnh sửa',style: TextStyle(fontSize: 20,color: Colors.white),),
                                Icon(Icons.navigate_next,size: 35,color: Colors.white,)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                      :
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green.withOpacity(0.4)
                        ),
                        height: 130,
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 10,left: 5,right: 5),
                        child: Container(
                          margin: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Doanh thu Tháng ${DateTime.now().month}: ',style: TextStyle(fontSize: 20),),
                                  Container(
                                    child: Text('${DateTime.now().month}/${DateTime.now().year}',style: TextStyle(fontSize: 18),),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('${formatter.format(num.parse(model.moneymonth(DateTime.now().month).toString()))}',style: TextStyle(fontSize: 25),),
                                  SizedBox(width: 10,),
                                  Text('VND',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700),),

                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap:(){
                                      var now = new DateTime.now();
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => MoreMonth(month: now.month),));
                                    },
                                    child: Container(
                                      child: Text('Xem chi tiết',style: TextStyle(fontSize: 18,color: Colors.blue),),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.pinkAccent.withOpacity(0.4)
                        ),
                        height: 150,
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 20,left: 5,right: 5),
                        child: Container(
                          margin: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Doanh thu hôm nay: ',style: TextStyle(fontSize: 20),),
                                  Container(
                                    child: Text('${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',style: TextStyle(fontSize: 18),),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('${formatter.format(num.parse(model.moneytoday().toString()))}',style: TextStyle(fontSize: 25),),
                                  SizedBox(width: 10,),
                                  Text('VND',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700),),
                                ],
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap:(){
                                      var now = new DateTime.now();
                                      var curentime = new DateTime(now.year,now.month,now.day);
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => MoreMoney(dateTime: curentime,money: model.moneytoday()),));
                                    },
                                    child: Container(
                                      child: Text('Xem chi tiết',style: TextStyle(fontSize: 18,color: Colors.blue),),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 20,left: 5,right: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.pinkAccent
                        ),
                        height: 60,
                        width: double.infinity,
                        child: GestureDetector(
                          onTap: () {
                            var now = new DateTime.now();
                            var curentime = new DateTime(now.year,now.month,now.day);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ReveDay(),));
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 10,right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Doanh thu các ngày trước',style: TextStyle(fontSize: 20,color: Colors.white),),
                                Icon(Icons.navigate_next,size: 35,color: Colors.white,)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 20,left: 5,right: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.pinkAccent
                        ),
                        height: 60,
                        width: double.infinity,
                        child: GestureDetector(
                          onTap: () {
                            var now = new DateTime.now();
                            var curentime = new DateTime(now.year,now.month,now.day);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ReveMonth(dateTime: curentime),));
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 10,right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Doanh thu các Tháng',style: TextStyle(fontSize: 20,color: Colors.white),),
                                Icon(Icons.navigate_next,size: 35,color: Colors.white,)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 20,left: 5,right: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.pinkAccent
                        ),
                        height: 60,
                        width: double.infinity,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen(),));
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 10,right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Chỉnh sửa',style: TextStyle(fontSize: 20,color: Colors.white),),
                                Icon(Icons.navigate_next,size: 35,color: Colors.white,)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              onRefresh: () async{
               await model.refesh();
              },
            )
          ],
        ),
      ),
    );
  }
}
