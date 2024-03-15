import 'package:flutter/cupertino.dart';
import '../splash_screen.dart';
import '../view/auth/forgot_password.dart';
import '../view/auth/login.dart';
import '../view/auth/reset_password.dart';



class Routes{
  static String splashScreen='/';
  static String loginScreen='/LoginScreen';
  static String forgotPassword='/ForgotPassword';
  static String resetPassword='/ResetPassword';
  static String bottomScreen='/BottomScreen';


  static Map<String, Widget Function(BuildContext)> routeMap={
    splashScreen: (context) => const SplashScreen(),
    loginScreen: (context) => const LoginScreen(),
    forgotPassword: (context) => const ForgotPassword(),
    resetPassword: (context) => const ResetPassword(),
    //bottomScreen: (context) => const BottomScreen(),
  };
}