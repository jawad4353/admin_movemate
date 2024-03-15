import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../main.dart';
import '../../utilis/app_colors.dart';
import '../../utilis/app_constants.dart';
import '../../utilis/app_images.dart';
import '../../utilis/app_preferences.dart';
import '../../utilis/app_routes.dart';
import '../../utilis/app_text_styles.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Size ? size;
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  String errorEmail='',errorPassword='';
  bool rememberMe=true;
  bool hidePassword=true;

  @override
  void initState() {
    super.initState();
    if(preferences.getString(AppPrefs.keyRememberMeEmail) != null){
      emailController.text=preferences.getString(AppPrefs.keyRememberMeEmail)!;
      passwordController.text=preferences.getString(AppPrefs.keyRememberMePassword)!;
    }
  }


  @override
  Widget build(BuildContext context) {
    size=MediaQuery.of(context).size;
    return   Scaffold(
      body: Row(children: [
        Expanded(child: leftSide()),
        Expanded(child: rightSide())
      ],),
    );
  }


  Widget leftSide(){
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: Image.network('https://source.unsplash.com/800x600/?bus').image,colorFilter: ColorFilter.mode(AppColors.black000000.withOpacity(0.7), BlendMode.darken),fit: BoxFit.fill),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.blue1E85FF.withOpacity(0.8),AppColors.blue659AD9,AppColors.blue85B8F3,AppColors.blue659AD9,AppColors.blue1E85FF.withOpacity(0.8)])
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),

          Column(children: [
            Image.asset(AppImages.iconBus,color: AppColors.whiteFFFFFF,height: size!.width*0.15,),
            Text(AppConstants.leftTitle,style: AppTextStyles.gotham(color: AppColors.whiteFFFFFF, fontSize: 24, weight: FontWeight.w500),textAlign: TextAlign.center,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: size!.width*0.052),
              child: Text(AppConstants.authDescription,style: AppTextStyles.gotham(color: AppColors.whiteFFFFFF, fontSize: 14, weight: FontWeight.w500),textAlign: TextAlign.center,),
            ),
          ],),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment:MainAxisAlignment.spaceAround ,
              children: [
                const Text(''),
                Row(children: [
                  Image.asset(AppImages.iconC,height: 21,color: AppColors.whiteFFFFFF,),
                  Text(AppConstants.authUnity+AppConstants.allRightReserved,style: AppTextStyles.gotham(color: AppColors.whiteFFFFFF, fontSize: 13, weight: FontWeight.w500)),

                ],),
                Text('Ver. 1.1.0',style:  AppTextStyles.gotham(color: AppColors.whiteFFFFFF, fontSize: 13, weight: FontWeight.w500),),
              ],),
          )
        ],),
    );
  }

  Widget rightSide(){
    return Container(
      height: 560,
      margin: EdgeInsets.symmetric(horizontal: size!.width*0.07),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey3B3B3B.withOpacity(0.15),width: 1,),
          borderRadius: BorderRadius.circular(13)
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: size!.width*0.04),
        child: ListView(children: [
          const SizedBox(height: 40,),
          Image.asset(AppImages.iconLogo,height: size!.height*0.15,),
          const SizedBox(height: 10,),
          Text(AppConstants.welcome,style:  AppTextStyles.raleWay(color: AppColors.black000000, fontSize: 18, weight: FontWeight.w600),textAlign: TextAlign.center),
          Text(AppConstants.loginDescription,style:  AppTextStyles.raleWay(color: AppColors.black000000, fontSize: 13, weight: FontWeight.w500),textAlign: TextAlign.center),

          const SizedBox(height: 40,),
          textField(fieldNumber:1 ,hintText:AppConstants.emailAddress,controller: emailController,formatter:FilteringTextInputFormatter.allow(
            RegExp(r'[a-zA-Z0-9@._-]'),
          )),

          SizedBox(height: 20,child: Text(' $errorEmail',style: AppTextStyles.gotham(color: AppColors.red, fontSize: 13, weight: FontWeight.w500),),),
          textField(fieldNumber:2 ,hintText: AppConstants.password,controller: passwordController,formatter:FilteringTextInputFormatter.deny(
            RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'),
          )),

          SizedBox(height: 20,child: Text(' $errorPassword',style: AppTextStyles.gotham(color: AppColors.red, fontSize: 13, weight: FontWeight.w500),),),
          forgotPasswordRememberMe(),
          const SizedBox(height: 40,),
          SizedBox(
            height: 45,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue1E85FF,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                onPressed: (){


                  if(emailController.text.isEmpty){
                    setState(() {errorEmail='Please enter email';});

                  }

                  if((emailController.text.length<5 || !emailController.text.endsWith('.com')) && emailController.text.isNotEmpty ){
                    setState(() {errorEmail='Please enter valid email';});
                  }

                  if(passwordController.text.isEmpty){
                    setState(() {errorPassword='Please enter password';});
                  }
                  if(passwordController.text.length<3 && passwordController.text.isNotEmpty){
                    setState(() {errorPassword='Password must have length 3';});
                    return;
                  }


                }, child: Text(AppConstants.login,style:AppTextStyles.raleWay(color: AppColors.whiteFFFFFF, fontSize: 14, weight: FontWeight.w600) ,)),
          )


        ],),
      ),
    );
  }


  Widget textField({required hintText,required fieldNumber,required TextEditingController controller,required  formatter }){
    return SizedBox(
      height: 48,
      child: TextFormField(
        controller: controller,
        cursorColor: AppColors.primary,
        inputFormatters: [formatter],
        obscureText: fieldNumber==2 ? hidePassword :false,
        decoration: InputDecoration(
          filled: true,
          suffixIcon:fieldNumber==2 ?  IconButton(onPressed: (){
            setState(() {hidePassword=!hidePassword;});
          },icon: Image.asset(hidePassword ? AppImages.iconVisibility:AppImages.iconVisibilityOff,color: AppColors.grey3B3B3B.withOpacity(0.3),height: 24,)):null,
          hintStyle: AppTextStyles.raleWay(color: AppColors.grey3B3B3B.withOpacity(0.8), fontSize: 13, weight: FontWeight.w300),
          hintText: hintText,
          fillColor: AppColors.pureWhite,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: AppColors.grey3B3B3B.withOpacity(0.1),width: 1)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: AppColors.grey3B3B3B.withOpacity(0.1),width: 1)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: AppColors.grey3B3B3B.withOpacity(0.1),width: 1)
          ),


        ),
      ),
    );
  }


  Widget forgotPasswordRememberMe(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          Checkbox(value: rememberMe, onChanged: (a){setState(() {
            rememberMe=!rememberMe;
          });}),
          Text(AppConstants.rememberMe,style: AppTextStyles.workSans(color: AppColors.grey3B3B3B.withOpacity(0.9), fontSize: 13, weight: FontWeight.w500),),
        ],),
        TextButton(onPressed: (){
          Navigator.pushNamed(context, Routes.forgotPassword);
        }, child: Text(AppConstants.forgotPassword,style:AppTextStyles.workSans(color: AppColors.primary, fontSize: 14, weight: FontWeight.w500,underline: true) ,))
      ],);
  }


}