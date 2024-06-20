import 'package:arobisca_online_store_app/core/data/data_provider.dart';
import 'package:arobisca_online_store_app/models/user.dart';
import 'package:arobisca_online_store_app/screen/authentication/onboarding/onboarding.dart';
import 'package:arobisca_online_store_app/screen/home_screen.dart';
import 'package:arobisca_online_store_app/screen/product_by_category_screen/provider/product_by_category_provider';
import 'package:arobisca_online_store_app/screen/product_details_screen/provider/product_detail_provider.dart';
import 'package:arobisca_online_store_app/screen/authentication/login_screen/provider/user_provider.dart';
import 'package:arobisca_online_store_app/screen/product_cart_screen/provider/cart_provider.dart';
import 'package:arobisca_online_store_app/screen/product_favorite_screen/provider/favorite_provider.dart';
import 'package:arobisca_online_store_app/screen/profile_screen/provider/profile_provider.dart';
import 'package:arobisca_online_store_app/utility/app_color.dart';
import 'package:arobisca_online_store_app/utility/app_theme.dart';
import 'package:arobisca_online_store_app/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cart/cart.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'dart:ui' show PointerDeviceKind;
import 'package:provider/provider.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColor.coffeeColor, // Set status bar color to black
    statusBarIconBrightness: Brightness.light, // Set text/icons to white
  ));
  
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  var cart = FlutterCart();

  //todo should complete add one signal app id
  OneSignal.initialize("49e4ade7-74b7-455b-a19d-d9b66a14e043");
  OneSignal.Notifications.requestPermission(true);
  await cart.initializeCart(isPersistenceSupportEnabled: true);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider(context.dataProvider)),
        ChangeNotifierProvider(create: (context) => ProfileProvider(context.dataProvider)),
        ChangeNotifierProvider(create: (context) => ProductByCategoryProvider(context.dataProvider)),
        ChangeNotifierProvider(create: (context) => ProductDetailProvider(context.dataProvider)),
        ChangeNotifierProvider(create: (context) => CartProvider(context.userProvider)),
        ChangeNotifierProvider(create: (context) => FavoriteProvider(context.dataProvider)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    User? loginUser = context.userProvider.getLoginUsr();
    return GetMaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
        },
      ),
      debugShowCheckedModeBanner: false,
      home: loginUser?.sId == null ? const OnBoardingScreen() : const HomeScreen(),
      theme: AppTheme.lightAppTheme,
    );
  }
}
