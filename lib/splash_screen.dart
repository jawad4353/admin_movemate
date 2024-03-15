import 'dart:async';
import 'package:flutter/material.dart';
import 'main.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    customizeEasyLoading();
    if(preferences.getString(AppPrefs.keyEmail)==null){
      Timer(const Duration(milliseconds: 2300),()=>Navigator.pushNamed(context, Routes.loginScreen));
    }
    else{
      Timer(const Duration(milliseconds: 2300),()=>Navigator.pushNamed(context, Routes.bottomScreen));
    }
  }


  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: SizedBox(
            width: size.width*0.2 ,
            height: size.height*0.3,
            child: LottieBuilder.asset(AppImages.splashLottie,fit: BoxFit.fill,)),
      ),
    );
  }

  void customizeEasyLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 35.0
      ..lineWidth = 49.0
      ..textStyle = TextStyle(height: 1.5, color: AppColors.whiteFFFFFF)
      ..radius = 10.0
      ..progressColor = AppColors.whiteFFFFFF
      ..backgroundColor = AppColors.primary
      ..indicatorColor = AppColors.whiteFFFFFF
      ..textColor = AppColors.whiteFFFFFF
      ..maskColor = AppColors.whiteFFFFFF.withOpacity(0.5)
      ..userInteractions = false
      ..dismissOnTap = true;
  }
}