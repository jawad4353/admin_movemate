import 'package:admin_movemate/utilis/app_colors.dart';
import 'package:admin_movemate/utilis/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

//https://source.unsplash.com/800x600/?nature

late SharedPreferences  preferences;
String bearerToken='';

Future<void> main() async {
  preferences=await SharedPreferences.getInstance();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder:  EasyLoading.init(),
      title: 'Unity',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor:AppColors.primary),
        useMaterial3: true,
      ),
      initialRoute: Routes.splashScreen,
      routes: Routes.routeMap,
      navigatorObservers: [],

    );
  }
}