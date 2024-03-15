import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utilis/app_colors.dart';
import '../../utilis/app_constants.dart';
import '../../utilis/app_images.dart';
import '../../utilis/app_routes.dart';
import '../../utilis/app_text_styles.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  Size ? size;
  TextEditingController emailController=TextEditingController();
  String errorEmail='';

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
            Image.asset(AppImages.iconUnity,color: AppColors.whiteFFFFFF,height: size!.width*0.15,),
            Text(AppConstants.effortlessAttendanceTitle,style: AppTextStyles.gotham(color: AppColors.whiteFFFFFF, fontSize: 24, weight: FontWeight.w500),textAlign: TextAlign.center,),
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
                  Image.asset(AppImages.iconC,height: 24,color: AppColors.whiteFFFFFF,),
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
      height: 480,
      margin: EdgeInsets.symmetric(horizontal: size!.width*0.07),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey3B3B3B.withOpacity(0.15),width: 1,),
          borderRadius: BorderRadius.circular(13)
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: size!.width*0.04),
        child: ListView(children: [
          const SizedBox(height: 40,),
          Image.asset(AppImages.iconLogo,height: size!.height*0.08,),
          const SizedBox(height: 10,),
          Text(AppConstants.forgotPasswordHeading,style:  AppTextStyles.raleWay(color: AppColors.black000000, fontSize: 18, weight: FontWeight.w600),textAlign: TextAlign.center),
          Text(AppConstants.forgotPasswordDescription,style:  AppTextStyles.raleWay(color: AppColors.black000000, fontSize: 13, weight: FontWeight.w500),textAlign: TextAlign.center),
          const SizedBox(height: 40,),
          textField(fieldNumber:1 ,hintText:AppConstants.emailAddress,controller: emailController,formatter:FilteringTextInputFormatter.allow(
            RegExp(r'[a-zA-Z0-9@._-]'),
          )),
          SizedBox(height: 20,child: Text(' $errorEmail',style: AppTextStyles.gotham(color: AppColors.red, fontSize: 13, weight: FontWeight.w500),),),
          backToLogin(),
          const SizedBox(height: 10,),
          SizedBox(
            height: 45,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue1E85FF,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                onPressed: (){

                  if(emailController.text.isEmpty){
                    setState(() {errorEmail='Please enter email';});
                    return;
                  }

                  if((emailController.text.length<5 || !emailController.text.endsWith('.com')) && emailController.text.isNotEmpty ){
                    setState(() {errorEmail='Please enter valid email';});
                    return;
                  }

                }, child: Text(AppConstants.submit,style:AppTextStyles.raleWay(color: AppColors.whiteFFFFFF, fontSize: 14, weight: FontWeight.w600) ,)),
          )


        ],),
      ),
    );
  }
  Widget textField({required hintText,required fieldNumber,required TextEditingController controller,required  formatter  }){
    return SizedBox(
      height: 48,
      child: TextFormField(
        controller: controller,
        inputFormatters: [formatter],
        decoration: InputDecoration(
          filled: true,
          hintStyle: AppTextStyles.raleWay(color: AppColors.grey3B3B3B.withOpacity(0.8), fontSize: 13, weight: FontWeight.w300),
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
          hintText: hintText,

        ),
      ),
    );
  }

  Widget backToLogin(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppConstants.backTo,style: AppTextStyles.raleWay(color: AppColors.black000000.withOpacity(0.8), fontSize: 13, weight: FontWeight.w400),),
        TextButton(onPressed: (){
          Navigator.pushNamed(context, Routes.loginScreen);
        }, child: Text(AppConstants.login,style: AppTextStyles.raleWay(color: AppColors.primary, fontSize: 13, weight: FontWeight.w600),)),
      ],);
  }
}