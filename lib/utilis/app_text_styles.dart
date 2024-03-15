import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_fonts.dart';

class AppTextStyles{

  static TextStyle? gotham({required color,required fontSize,required FontWeight weight}){
    return TextStyle(color: color,fontWeight:weight,fontSize: fontSize,fontFamily: AppFontFamilies.fontGotham );
  }

  static TextStyle? raleWay({required color,required fontSize,required FontWeight weight}){
    return TextStyle(color: color,fontWeight:weight,fontSize: fontSize,fontFamily: AppFontFamilies.fontRaleway );
  }
  static TextStyle? workSans({required color,required fontSize,required FontWeight weight,bool underline = false}){
    return TextStyle(color: color,fontWeight:weight,fontSize: fontSize,fontFamily: AppFontFamilies.fontWorkSans ,decoration: underline ?TextDecoration.underline:TextDecoration.none,decorationColor: AppColors.primary);
  }
}