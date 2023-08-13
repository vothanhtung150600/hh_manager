import 'package:CFM/Model/provider_money.dart';
import 'package:CFM/mongodb/mongodatabase.dart';
import 'package:CFM/utils/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';

import '../Model/model.dart';
import '../Model/provider_model.dart';
import '../dialog/showdialog.dart';
import '../main.dart';
import '../router.dart';



bool insert = false;

class OrderPage extends StatefulWidget {
  int sumquantity;
  double total;
  List<Product> listdata;
  OrderPage({Key? key,required this.sumquantity,required this.total,required this.listdata}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<Revenue> listtotal = [];
  final formatter = NumberFormat('###,###,###');

  @override
  Widget build(BuildContext context) {
    Homemodel model = Provider.of<Homemodel>(context);
    Moneymodel modelmoney = Provider.of<Moneymodel>(context);

    return SafeArea(
        child: Stack(
          children: [
            Scaffold(
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.pinkAccent))
                ),
                height: 60,
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Text('Tổng Tiền:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                            Container(
                                margin: EdgeInsets.only(left: 20,right: 5),
                                child: Text('${formatter.format(num.parse(widget!.total.toString()))} đ',style: TextStyle(fontSize: 19),))
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await messageAccess(
                            context,
                            'Bạn đã kiểm tra kỹ chưa ?',
                            onPressCancel: () {},
                            onPressOK: () async {
                              insertdata(widget.total,DateTime.now(),widget.listdata);
                              Navigator.pop(context);
                              await modelmoney!.refesh();
                              model.clearproduct();
                              await Navigator.of(context).pushReplacementNamed(RouteName.tab).then((value) {setState(() {
                              });});
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.pinkAccent.withOpacity(0.8),
                          ),
                          child: Container(
                              margin: EdgeInsets.only(left: 20,right: 20),
                              child: Center(child: Text('Thanh toán',style: TextStyle(fontSize: 20),))),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              appBar: AppBar(
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back,color: Colors.black,),
                ),
                toolbarHeight: 60,
                backgroundColor: Colors.white,
                title: Text('Huỳnh Hằng Coffee',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.pinkAccent,fontSize: 24),),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.pinkAccent.withOpacity(0.3)
                      ),
                      margin: EdgeInsets.only(left: 10,top: 10,right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Tổng SL đã chọn:',style: TextStyle(fontSize: 20)),
                          Text('${widget.sumquantity}',style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                    Container(
                      height: 40,
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 10,top: 20,right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Sản phẩm đã chọn',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.pinkAccent.withOpacity(0.6)
                              ),
                              child: Container(
                                margin: EdgeInsets.all(10),
                                  child: Text('Thêm',style: TextStyle(fontSize: 18))),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10,top: 10,right: 20),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        addAutomaticKeepAlives: true,
                        itemCount: widget.listdata.length,
                        itemBuilder:(context, index) {
                          var data = widget.listdata[index];
                          var sumprice = (data.quantity) !* (data.price!);
                          return Container(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('- ${data.quantity}x  ${data.name}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                                Text('${formatter.format(num.parse(sumprice.toString()))} đ',style: TextStyle(fontSize: 18)),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
                visible: modelmoney!.isLoading,
                child: Container(
                  height: double.infinity,
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoadingWidget(),
                      ],
                    ))
            )
          ],
        )
    );
  }
  Future<void> insertdata(double summoney,DateTime date,List<Product> listdata) async{
    final data = Revenue(money: summoney,date: date,product: listdata);
    await MongoDB.createmoney(data);
  }
}
