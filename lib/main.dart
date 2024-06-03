import 'package:arobisca_online_store_app/core/data/data_provider.dart';
import 'package:arobisca_online_store_app/screen/authentication/onboarding/onboarding.dart';
import 'package:arobisca_online_store_app/screen/authentication/password_reset/set_new_password.dart';
import 'package:arobisca_online_store_app/screen/home_screen';
import 'package:arobisca_online_store_app/screen/product_by_category_screen/provider/product_by_category_provider';
import 'package:arobisca_online_store_app/screen/product_details_screen/provider/product_detail_provider.dart';
import 'package:arobisca_online_store_app/screen/authentication/login_screen/provider/user_provider.dart';
import 'package:arobisca_online_store_app/screen/product_cart_screen/provider/cart_provider.dart';
import 'package:arobisca_online_store_app/screen/product_favorite_screen/provider/favorite_provider.dart';
import 'package:arobisca_online_store_app/screen/profile_screen/provider/profile_provider.dart';
import 'package:arobisca_online_store_app/utility/app_theme.dart';
import 'package:arobisca_online_store_app/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/cart.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'dart:ui' show PointerDeviceKind;
import 'package:provider/provider.dart';
import 'package:uni_links2/uni_links.dart';
import 'models/user.dart';
import 'dart:async';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  var cart = FlutterCart();

  //todo should complete add one signal app id
  OneSignal.initialize("YOUR_ONE_SIGNAL_APP_ID");
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    initUniLinks();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  void initUniLinks() async {
    _sub = linkStream.listen((String? link) {
      if (link != null) {
        final Uri uri = Uri.parse(link);
        if (uri.host == 'localhost' && uri.path == '/password/resetPassword') {
          final String? token = uri.queryParameters['token'];
          if (token != null) {
            Navigator.pushNamed(context, '/reset-password', arguments: token);
          }
        }
      }
    }, onError: (err) {
      // Handle error
    });

    // Handle initial link if the app was launched from a deep link
    final initialLink = await getInitialLink();
    if (initialLink != null) {
      final Uri uri = Uri.parse(initialLink);
      if (uri.host == 'localhost' && uri.path == '/password/resetPassword') {
        final String? token = uri.queryParameters['token'];
        if (token != null) {
          Navigator.pushNamed(context, '/reset-password', arguments: token);
        }
      }
    }
  }

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
      onGenerateRoute: (settings) {
        if (settings.name == '/reset-password') {
          final String? token = settings.arguments as String?;
          return MaterialPageRoute(
            builder: (context) => const SetNewPassword(),
          );
        }
        return null;
      },
    );
  }
}
