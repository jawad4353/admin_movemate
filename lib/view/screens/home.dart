

import 'package:admin_movemate/utilis/app_constants.dart';
import 'package:admin_movemate/utilis/app_text_styles.dart';
import 'package:admin_movemate/view/screens/pie_chart.dart';
import 'package:flutter/material.dart';

import '../../utilis/app_colors.dart';
import '../../utilis/app_images.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Size  ? size;

  @override
  Widget build(BuildContext context) {
    size=MediaQuery.of(context).size;
    return Scaffold(
      body:ListView(children: [
        topBoxes(),
        pieCharts()

      ],) ,
    );
  }

  Widget pieCharts(){
    return SizedBox(
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
        PieChartWidget(verifiedColor: AppColors.primary, unverifiedColor:AppColors.lime, verifiedValue: 37, unverifiedValue: 63,unverifiedTitle: AppConstants.unverifiedUsers,verifiedTitle:AppConstants.verifiedUsers ),
        PieChartWidget(verifiedColor: AppColors.lightGreen, unverifiedColor: AppColors.red, verifiedValue: 73, unverifiedValue: 25,unverifiedTitle:AppConstants.unverifiedAdmins,verifiedTitle:AppConstants.verifiedAdmins),
        PieChartWidget(verifiedColor: AppColors.blue, unverifiedColor: AppColors.orange, verifiedValue: 65, unverifiedValue: 43,unverifiedTitle: AppConstants.unresolvedComplains,verifiedTitle:AppConstants.resolvedComplains),
      ],),
    );
  }

  Widget topBoxes(){
    return SizedBox(
      height: 150,
      child: Wrap(
        alignment: WrapAlignment.spaceAround,
        direction:Axis.horizontal ,
        children: [
        boxes(title: 'Users', number: '150', icon:AppImages.iconStudent, verified: '43', unverified: '107'),
        //boxes(title: 'Drivers', number: '15', icon: Icons.person, verified: '10', unverified: '5'),
        boxes(title: 'Complains', number: '55', icon: AppImages.iconComplains, verified: '13', unverified: '66'),
        boxes(title: 'Buses', number: '55', icon:AppImages.iconBusr, verified: null, unverified: null),
          boxes(title: 'Routes', number: '25', icon: AppImages.iconRoutes, verified: null, unverified: null),
          boxes(title: 'Admins', number: '5', icon: AppImages.iconStudent, verified: '3', unverified: '4'),
      ],),
    );
  }



  Widget boxes({required title,required number,required icon,required verified,required unverified}){
    return Container(
      height: size!.width<680 ? 90  :110,
      width: size!.width<680 ? 180 : size!.width*0.17,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [AppColors.primary,AppColors.lightGreen]),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [BoxShadow(color: Colors.black12,spreadRadius: 0.5),]
      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(number,style: AppTextStyles.raleWay(color: AppColors.pureWhite, fontSize: 22, weight: FontWeight.w600),),
              Text(title,style: AppTextStyles.raleWay(color: AppColors.pureWhite, fontSize: 16, weight: FontWeight.w600)),
            ],),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(icon,color: AppColors.whiteFFFFFF,height: 30,),
              if(verified!=null && unverified!=null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(children: [
                      Text('${AppConstants.verified} :  ',style: AppTextStyles.raleWay(color: AppColors.pureWhite, fontSize: 15, weight: FontWeight.w500)),
                      Text(verified,style:AppTextStyles.raleWay(color: AppColors.pureWhite, fontSize: 15, weight: FontWeight.w600)),
                    ],),
                    Row(children: [
                      Text('${AppConstants.pending} :  ',style: AppTextStyles.raleWay(color: AppColors.pureWhite, fontSize: 15, weight: FontWeight.w500)),
                      Text(unverified,style:AppTextStyles.raleWay(color: AppColors.pureWhite, fontSize: 15, weight: FontWeight.w600)),
                    ],),
                  ],),
              if(verified==null && unverified==null)
                Column(children: [
                  Row(children: [
                    Text('${AppConstants.total} :  ',style: AppTextStyles.raleWay(color: AppColors.pureWhite, fontSize: 15, weight: FontWeight.w500)),
                    Text(number,style: AppTextStyles.raleWay(color: AppColors.pureWhite, fontSize: 15, weight: FontWeight.w600)),
                  ],),
                  const Row(children: [
                    Text(''),
                    Text(''),
                  ],),
                ],)
            ],),
        ],),

    );
  }


}
