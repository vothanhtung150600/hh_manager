

import 'dart:ui';

import 'package:CFM/Model/provider_money.dart';
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
  Homemodel? model;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    model = Provider.of<Homemodel>(context);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    model = Provider.of<Homemodel>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text('Huỳnh Hằng Coffee',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.pinkAccent),),
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
                          crossAxisCount: 4,
                          mainAxisExtent: 120,
                          crossAxisSpacing: 10,
                        ),
                        itemCount: listdatabanner.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () => Scrollable.ensureVisible(keyCap[index].currentContext!),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    maxRadius: 30,
                                    child: Container(
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
                                          borderRadius: BorderRadius.circular(360)
                                      ),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                                        child: Container(
                                          color: Colors.white.withOpacity(0.2),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Container(
                                    alignment: Alignment.center,
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
                        enabled: model!.isLoading,
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
                                width: double.infinity,
                                margin: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin: EdgeInsets.all(5),
                                        child: Image.asset('assets/product/cafe.png'),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 20,top: 15,bottom: 10,right: 10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Text(
                                                'nuoc ngot thuy tinh',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    child: Text('10.000đ',style: TextStyle(fontSize: 16),),
                                                  ),
                                                  Container(
                                                    child: Icon(
                                                      color: Colors.white,
                                                      Icons.add,
                                                    ),
                                                  ),
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
                                width: double.infinity,
                                margin: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin: EdgeInsets.all(5),
                                        child: Image.asset('assets/product/cafe.png'),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 20,top: 15,bottom: 10,right: 10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Text(
                                                'nuoc ngot thuy tinh',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    child: Text('10.000đ',style: TextStyle(fontSize: 16),),
                                                  ),
                                                  Container(
                                                    child: Icon(
                                                      color: Colors.white,
                                                      Icons.add,
                                                    ),
                                                  ),
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
                                width: double.infinity,
                                margin: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin: EdgeInsets.all(5),
                                        child: Image.asset('assets/product/cafe.png'),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 20,top: 15,bottom: 10,right: 10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Text(
                                                'nuoc ngot thuy tinh',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    child: Text('10.000đ',style: TextStyle(fontSize: 16),),
                                                  ),
                                                  Container(
                                                    child: Icon(
                                                      color: Colors.white,
                                                      Icons.add,
                                                    ),
                                                  ),
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
                                width: double.infinity,
                                margin: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin: EdgeInsets.all(5),
                                        child: Image.asset('assets/product/cafe.png'),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 20,top: 15,bottom: 10,right: 10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Text(
                                                'nuoc ngot thuy tinh',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    child: Text('10.000đ',style: TextStyle(fontSize: 16),),
                                                  ),
                                                  Container(
                                                    child: Icon(
                                                      color: Colors.white,
                                                      Icons.add,
                                                    ),
                                                  ),
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
                                        width: double.infinity,
                                        margin: EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                margin: EdgeInsets.all(5),
                                                child: Image.network(data.image!),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                margin: EdgeInsets.only(left: 10,top: 15,bottom: 10,right: 10),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        data.name!,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Container(
                                                            child: Text('${data.price.toString().toVND(unit: 'đ')}',style: TextStyle(fontSize: 16),),
                                                          ),
                                                          Container(
                                                            child: GestureDetector(
                                                              onTap: () async{
                                                                messageReport(
                                                                    context,
                                                                    data.name!,
                                                                    data.price!,
                                                                    onPressOK: (value) async{
                                                                      var money = int.parse(value.text);
                                                                      updateproduct(data.name!,money);
                                                                      await model!.refesh();
                                                                    }
                                                                );
                                                              },
                                                              child: Container(
                                                                child: CircleAvatar(
                                                                  backgroundColor: Colors.pinkAccent.withOpacity(0.7),
                                                                  child: Icon(
                                                                    color: Colors.white,
                                                                    Icons.settings,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
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
                  await model!.refesh();
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
