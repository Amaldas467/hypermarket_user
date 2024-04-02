import 'package:flutter/material.dart';
import 'package:hypermarket_user/presentation/cart_screen/controller/cart_screen_controller.dart';
import 'package:hypermarket_user/presentation/category_screen/controller/category_screen_controller.dart';
import 'package:hypermarket_user/presentation/login_screen/controller/login_controller.dart';
import 'package:hypermarket_user/presentation/personal_deatils/controller/profile_details.dart';
import 'package:hypermarket_user/presentation/product_details_screen/controller/product_details_screen_controller.dart';
import 'package:hypermarket_user/presentation/product_screen/controller/product_screen_controller.dart';
import 'package:hypermarket_user/presentation/registration__screen/controller/register_screen_controller.dart';
import 'package:hypermarket_user/presentation/category_search_screen/controller/search_screen_controller.dart';
import 'package:hypermarket_user/presentation/scanner_screen/controller/scanned_product_details_controller.dart';
import 'package:hypermarket_user/presentation/splash_screen/splash_screen.dart';

import 'package:provider/provider.dart';

import 'presentation/purchase_history_screen/controller/purcharse_history_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => ProductDetailsScreenController()),
        ChangeNotifierProvider(create: (context) => CartScreenController()),
        ChangeNotifierProvider(
            create: (context) => RegistrationScreenController()),
        ChangeNotifierProvider(create: (context) => LoginScreenController()),
        ChangeNotifierProvider(
            create: (context) => RegistrationScreenController()),
        ChangeNotifierProvider(create: (context) => CategoryScreenController()),
        ChangeNotifierProvider(create: (context) => ProductScreenController()),
        ChangeNotifierProvider(
            create: (context) => ProductDetailsScreenController()),
        ChangeNotifierProvider(create: (context) => HistoryScreenController()),
        ChangeNotifierProvider(
            create: (context) => SearchScreenScreenController()),
        ChangeNotifierProvider(
            create: (context) => scanedDetailsScreenController()),
        ChangeNotifierProvider(
            create: (context) => ProfileDetailsScreenController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
