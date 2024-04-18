import 'package:hive_flutter/hive_flutter.dart';

class HiveBox {
  Box<dynamic> get logInfo => Hive.box('login_info');
  Box<dynamic> get addToCart => Hive.box('add_to_cart');

  
}