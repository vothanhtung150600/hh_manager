

import 'dart:ui';

import 'package:CFM/dialog/showdialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../Model/model.dart';
import '../../Model/provider_model.dart';
import '../../mongodb/mongodatabase.dart';
import '../../router.dart';
import '../../utils/loading_widget.dart';

class UpdateProduct extends StatefulWidget {
  const UpdateProduct({Key? key}) : super(key: key);

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  final _scrollController = ScrollController();
  final dataKey = new GlobalKey();
  List<GlobalKey> keyCap = listdatabanner.map((e) => GlobalKey()).toList();
  final formatter = NumberFormat('###,###,###');
  @override
  Widget build(BuildContext context) {
    Homemodel model = Provider.of<Homemodel>(context);
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
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        addAutomaticKeepAlives: true,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisExtent: 130,
                            crossAxisSpacing: 10
                        ),
                        itemCount: listdatabanner.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () => Scrollable.ensureVisible(keyCap[index].currentContext!),
                              child: Column(
                                children: [
                                  SizedBox(height: 10,),
                                  Container(
                                    height: 70,
                                    margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.pinkAccent.withOpacity(0.6),
                                            blurRadius: 8,
                                            offset: Offset(0,2), //// Shadow position
                                          ),
                                        ],
                                        border: Border.all(
                                            color: Colors.white
                                        ),
                                        image: DecorationImage(
                                            image: AssetImage(listdatabanner[index].image),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                                      child: Container(
                                        color: Colors.white.withOpacity(0.2),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 70,
                                    child: Text(listdatabanner[index].name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              )
                          );
                        },
                      ),
                      Skeletonizer(
                        enabled: model.isLoading,
                        child: model!.isLoading ? Padding(
                          padding: EdgeInsets.all(0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: 10,top: 10),
                                child: Text('Nước giải khát',style: TextStyle(fontSize: 22),),
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.pinkAccent.withOpacity(0.6),
                                        blurRadius: 8,
                                        offset: Offset(0,2), //// Shadow position
                                      ),
                                    ]
                                ),
                                height: 120,
                                margin: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(5),
                                          width: 100,
                                          child: Image.asset('assets/product/cafe.png'),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 20,top: 15,bottom: 10),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 180,
                                                child: Text(
                                                  'Nuoc ngot thuy tinh',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 30,
                                                    margin: EdgeInsets.only(top: 10,right: 60,bottom: 10),
                                                    child: Text('10.000đ',style: TextStyle(fontSize: 16),),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.bottomRight,
                                                    child: Container(
                                                      margin: EdgeInsets.only(top: 10,left: 60),
                                                      child: Icon(
                                                        size: 40,
                                                        color: Colors.white,
                                                        Icons.add,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.pinkAccent.withOpacity(0.6),
                                        blurRadius: 8,
                                        offset: Offset(0,2), //// Shadow position
                                      ),
                                    ]
                                ),
                                height: 120,
                                margin: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(5),
                                          width: 100,
                                          child: Image.asset('assets/product/cafe.png'),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 20,top: 15,bottom: 10),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 180,
                                                child: Text(
                                                  'Nuoc ngot thuy tinh',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 30,
                                                    margin: EdgeInsets.only(top: 10,right: 60,bottom: 10),
                                                    child: Text('10.000đ',style: TextStyle(fontSize: 16),),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.bottomRight,
                                                    child: Container(
                                                      margin: EdgeInsets.only(top: 10,left: 60),
                                                      child: Icon(
                                                        size: 40,
                                                        color: Colors.white,
                                                        Icons.add,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.pinkAccent.withOpacity(0.6),
                                        blurRadius: 8,
                                        offset: Offset(0,2), //// Shadow position
                                      ),
                                    ]
                                ),
                                height: 120,
                                margin: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(5),
                                          width: 100,
                                          child: Image.asset('assets/product/cafe.png'),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 20,top: 15,bottom: 10),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 180,
                                                child: Text(
                                                  'Nuoc ngot thuy tinh',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 30,
                                                    margin: EdgeInsets.only(top: 10,right: 60,bottom: 10),
                                                    child: Text('10.000đ',style: TextStyle(fontSize: 16),),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.bottomRight,
                                                    child: Container(
                                                      margin: EdgeInsets.only(top: 10,left: 60),
                                                      child: Icon(
                                                        size: 40,
                                                        color: Colors.white,
                                                        Icons.add,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.pinkAccent.withOpacity(0.6),
                                        blurRadius: 8,
                                        offset: Offset(0,2), //// Shadow position
                                      ),
                                    ]
                                ),
                                height: 120,
                                margin: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(5),
                                          width: 100,
                                          child: Image.asset('assets/product/cafe.png'),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 20,top: 15,bottom: 10),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 180,
                                                child: Text(
                                                  'Nuoc ngot thuy tinh',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 30,
                                                    margin: EdgeInsets.only(top: 10,right: 60,bottom: 10),
                                                    child: Text('10.000đ',style: TextStyle(fontSize: 16),),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.bottomRight,
                                                    child: Container(
                                                      margin: EdgeInsets.only(top: 10,left: 60),
                                                      child: Icon(
                                                        size: 40,
                                                        color: Colors.white,
                                                        Icons.add,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ) :
                        ListView.builder(
                          shrinkWrap: true,
                          addAutomaticKeepAlives: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: model!.listmodel.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  key: keyCap[index],
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left: 10,top: 10),
                                  child: Text(model!.listmodel[index].type!,style: TextStyle(color: Colors.pinkAccent,fontSize: 22,fontWeight: FontWeight.w600),),
                                ),
                                SizedBox(height: 10,),
                                ListView.builder(
                                  shrinkWrap: true,
                                  addAutomaticKeepAlives: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: model!.listmodel[index].product!.length,
                                  itemBuilder: (context, indexitem) {
                                    var data = model!.listmodel[index].product![indexitem];
                                    return GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.pinkAccent.withOpacity(0.6),
                                                blurRadius: 8,
                                                offset: Offset(0,2), //// Shadow position
                                              ),
                                            ]
                                        ),
                                        height: 120,
                                        margin: EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.all(5),
                                                  width: 100,
                                                  child: Image.network(data.image!),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(left: 20,top: 15,bottom: 10),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        width: 180,
                                                        child: Text(
                                                          data.name!,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            height: 30,
                                                            margin: EdgeInsets.only(top: 10,right: 60,bottom: 10),
                                                            child: Text('${data.price.toString().toVND(unit: 'đ')}',style: TextStyle(fontSize: 16),),
                                                          ),
                                                          Container(
                                                            alignment: Alignment.bottomRight,
                                                            child: GestureDetector(
                                                              onTap: () {
                                                                messageReport(
                                                                    context,
                                                                    data.name!,
                                                                    data.price!,
                                                                    onPressOK: (value) async{
                                                                      var money = int.parse(value.text);
                                                                      updateproduct(data.name!,money);
                                                                      await model.refesh();
                                                                    }
                                                                );
                                                              },
                                                              child: Container(
                                                                margin: EdgeInsets.only(top: 10,left: 60),
                                                                child: Icon(
                                                                  color: Colors.pinkAccent,
                                                                  Icons.settings,
                                                                  size: 35,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
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
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 60,),
                    ],
                  ),
                ),
                onRefresh: () async{
                  await model.refesh();
                }
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () async{
                  await Navigator.of(context).pushReplacementNamed(RouteName.tab);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent.withOpacity(0.2),
                  ),
                  width: double.infinity,
                  height: 60,
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Text('Quay về Trang chủ',style: TextStyle(fontSize: 20),),
                    
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Future<void> updateproduct(String name,int money) async{
    final data = Product.update(name,money);
    await MongoDB.updatedata(data);
  }
}
