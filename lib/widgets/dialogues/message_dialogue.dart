import 'package:flutter/material.dart';
import 'package:unity_web_app/utilis/app_text_styles.dart';
import '../../utilis/app_colors.dart';
import '../../utilis/app_images.dart';

class MessageDialogue extends StatefulWidget {
  final String title;
  final String message;
  const MessageDialogue({super.key,required this.message,required this.title});

  @override
  State<MessageDialogue> createState() => _MessageDialogueState();
}

class _MessageDialogueState extends State<MessageDialogue> {
  @override
  Widget build(BuildContext context) {
    return  Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AppImages.iconLogo,height: 50,),
            const SizedBox(height: 15,),
            Text(widget.title,style: AppTextStyles.raleWay(color: AppColors.black000000, fontSize: 18, weight: FontWeight.w600),),
            const SizedBox(height: 5,),
            SizedBox(
                width: 250,
                child: Text(widget.message,style: AppTextStyles.raleWay(color: AppColors.black000000, fontSize: 13, weight: FontWeight.w600),textAlign: TextAlign.center,)),
          ],),
      ),
    );
  }
}