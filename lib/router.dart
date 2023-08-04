
import 'package:CFM/Screen/Admin/Update_product.dart';
import 'package:CFM/Screen/HomePage.dart';
import 'package:CFM/utils/page_route_anim.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class RouteName {
  static const String tab = '/';
  static const String home = 'homepage';
  static const String update = 'updatehome';


}

class Router2 {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.tab:
        return NoAnimRouteBuilder(MyHomePage());
      case RouteName.home:
        return NoAnimRouteBuilder(HomePage());
      case RouteName.update:
        return NoAnimRouteBuilder(UpdateProduct());

      default:
        return CupertinoPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ));
    }
  }
}
