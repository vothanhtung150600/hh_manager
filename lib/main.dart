import 'dart:ui';

import 'package:CFM/mongodb/mongodatabase.dart';
import 'package:CFM/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'Model/model.dart';
import 'Provider/provider_manager.dart';
import 'Screen/HomePage.dart';
import 'Screen/MoneyPage.dart';
import 'Screen/PersonPage.dart';
import 'package:path_provider/path_provider.dart' as path_provider;


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: "lib/.env");
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);


  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  print(dotenv.env['VAR_NAME']);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: providers,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Router2.generateRoute,
          initialRoute: RouteName.tab,
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    FlutterNativeSplash.remove();
  }
  @override
  void dispose() {
    super.dispose();
    Hive.close();
    _tabController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                HomePage(),
                MoneyPage(),
              ],
              controller: _tabController,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaY: 0, sigmaX: 0),
                    child: Container(
                      color: Colors.white,
                      height: 60,
                      child: TabBar(
                        indicatorColor: Colors.black26,
                        labelColor: Colors.pinkAccent,
                        unselectedLabelColor: Colors.black,
                        labelStyle: TextStyle(fontSize: 13.0),
                        tabs: <Widget>[
                          Tab(
                            icon: Icon(
                              Icons.home_filled,
                            ),
                            text: 'Trang chủ',
                          ),
                          Tab(
                            icon: Icon(
                              Icons.person_outline,
                            ),
                            text: 'Cá nhân',
                          )
                        ],
                        controller: _tabController,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

