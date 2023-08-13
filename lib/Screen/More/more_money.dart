
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../Model/provider_money.dart';
import '../../utils/loading_widget.dart';

class MoreMoney extends StatefulWidget {
  DateTime dateTime;
  double money;
  MoreMoney({Key? key,required this.dateTime,required this.money}) : super(key: key);

  @override
  State<MoreMoney> createState() => _MoreMoneyState();
}

class _MoreMoneyState extends State<MoreMoney> {
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
            backgroundColor: Colors.white,
            title: Text('Doanh thu ngày ${widget.dateTime.day}/${widget.dateTime.month}',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.pinkAccent),),
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
              model.listmoretoday(widget.dateTime).isEmpty ? Container(
                alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      JumpingText('Chưa có doanh thu cho hôm nay...',style: TextStyle(color: Colors.pinkAccent,fontSize: 16),)
                    ],
                  )) :
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10,top: 10,right: 20),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        addAutomaticKeepAlives: true,
                        itemCount: model.listmoretoday(widget.dateTime).length,
                        itemBuilder:(context, index) {
                          var a = model.listmoretoday(widget.dateTime)[index];
                          return Container(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('- ${a.quantity}x ${a.name}',style: TextStyle(fontSize: 18),),
                                Text('${formatter.format(num.parse(a.price.toString()))} đ',style: TextStyle(fontSize: 18),),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 120,)
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.pinkAccent.withOpacity(0.4),
                  height: 100,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10,right: 20),
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tổng số lượng: ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                            Text('${model.sumquantity(widget.dateTime)}',style: TextStyle(fontSize: 18),),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10,right: 20),
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tổng tiền: ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                            Text('${formatter.format(num.parse(widget.money.toString()))} đ',style: TextStyle(fontSize: 20),),
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
