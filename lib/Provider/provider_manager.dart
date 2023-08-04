
import 'package:CFM/Model/provider_model.dart';
import 'package:CFM/Model/provider_money.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...uiConsumableProviders,
];

List<SingleChildWidget> uiConsumableProviders = [

  ChangeNotifierProvider(
      create: (_) => Homemodel()..loaddata()
  ),
  ChangeNotifierProvider(
      create: (_) => Moneymodel()..loaddatamoney()..loaddatamonth()
  ),
];