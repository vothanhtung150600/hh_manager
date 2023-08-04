import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../Model/provider_money.dart';
import '../../utils/loading_widget.dart';
import 'more_money.dart';


class MoreMonth extends StatefulWidget {
  int month;
  MoreMonth({Key? key,required this.month}) : super(key: key);

  @override
  State<MoreMonth> createState() => _MoreMonthState();
}

class _MoreMonthState extends State<MoreMonth> {
  final formatter = NumberFormat('###,###,###');

  @override
  Widget build(BuildContext context) {
    Moneymodel model = Provider.of<Moneymodel>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          toolbarHeight: 60,
          backgroundColor: Colors.white,
          title: Text('Doanh thu tháng ${widget.month}',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.pinkAccent,fontSize: 24),),
        ),
        body:  Stack(
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
            model.listmoretomonth(widget.month).isEmpty ? Container(
              alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    JumpingText('Chưa có doanh thu cho tháng này....',style: TextStyle(color: Colors.pinkAccent,fontSize: 20),)
                  ],
                )) :
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 5,top: 5,right: 5),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      addAutomaticKeepAlives: true,
                      itemCount: model.listmoretomonth(widget.month).length,
                      itemBuilder:(context, index) {
                        var a = model.listmoretomonth(widget.month)[index];
                        DateTime day = DateFormat("yyyy-MM-dd").parseStrict(a.date);
                        var money = a.data.map((e) => e.money).reduce((value, element) => value + element);
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green.withOpacity(0.4)
                          ),
                          height: 90,
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 10,left: 5,right: 5,bottom: 5),
                          child: Container(
                            margin: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Doanh thu: ',style: TextStyle(fontSize: 18),),
                                    Container(
                                      child: Text('${day.day}/${day.month}/${day.year}',style: TextStyle(fontSize: 16),),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('${formatter.format(num.parse(money.toString()))}',style: TextStyle(fontSize: 20),),
                                    SizedBox(width: 10,),
                                    Text('VND',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap:(){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => MoreMoney(dateTime: day,money: money),));
                                      },
                                      child: Container(
                                        child: Text('Xem chi tiết',style: TextStyle(fontSize: 16,color: Colors.blue),),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 80,)
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.green.withOpacity(0.4),
                height: 60,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10,right: 20),
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Tổng tiền: ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                          Text('${formatter.format(num.parse(model.moneymonth(widget.month).toString()))} VND',style: TextStyle(fontSize: 20),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
