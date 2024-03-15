import 'package:flutter/material.dart';

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
    );
  }
}