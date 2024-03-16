import 'package:admin_movemate/utilis/app_text_styles.dart';
import 'package:admin_movemate/view/screens/admins.dart';
import 'package:admin_movemate/view/screens/buses.dart';
import 'package:admin_movemate/view/screens/conplains.dart';
import 'package:admin_movemate/view/screens/home.dart';
import 'package:admin_movemate/view/screens/notifications.dart';
import 'package:admin_movemate/view/screens/routes.dart';
import 'package:admin_movemate/view/screens/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utilis/app_colors.dart';
import '../utilis/app_images.dart';

class DashBoard extends StatelessWidget{
  final List<Widget> listScreen=[const HomeScreen(),const UsersScreen(),const BusesScreen(),
    const RoutesScreen(), const AdminsScreen(),const NotificationsScreen(), const Complains()];
  Size ? size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        SizedBox(
          width: size!.width*0.12,
            child: leftMenu(context)),
        const VerticalDivider(width: 1),
        Expanded(child: rightSide()),
      ],),
    );
  }

  Widget leftMenu(context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Image.asset(AppImages.iconLogo,height: 100,),
              ),
          menuButton(title: 'DashBoard', icon: AppImages.iconHome, context: context),
          menuButton(title: 'Users', icon: AppImages.iconStudent, context: context),
          menuButton(title: 'Buses', icon: AppImages.iconBusr, context: context),
          menuButton(title: 'Routes', icon: AppImages.iconRoutes, context: context),
          menuButton(title: 'Complains', icon: AppImages.iconComplains, context: context),
          menuButton(title: 'Admins', icon: AppImages.iconAdmins, context: context),
          menuButton(title: 'Logout', icon: AppImages.iconLogout, context: context),

      ],),
    );
  }
  Widget menuButton({required title,required String icon,required context}){
    return InkWell(
      onTap: (){
        if(title=='Home')
        {
          //Provider.of<ValueProvider1>(context,listen: false).setvalue(0);
        }
      },
      child: SizedBox(
        height: 35,
        child: Row(children: [
          SizedBox(width: size!.width*0.006,),
          Image.asset(icon,height: 22,color: AppColors.grey3B3B3B,),
          SizedBox(width: size!.width*0.004,),
          Text(title,style: AppTextStyles.workSans(color: AppColors.black000000, fontSize: 13, weight: FontWeight.w600),),

        ],),
      ),
    );
  }

  Widget rightSide() {
    return  Column(children: [
      header(),
      const Divider(),
      Container(
        color: AppColors.lightGreen,
          height:size!.height*0.91,child: listScreen[0])
    ],);
  }

  Widget header(){
    return Padding(
      padding:  const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
        IconButton(onPressed: (){}, icon: Image.asset(AppImages.iconSettings,height: 27,)),
          const SizedBox(width: 10,),
        IconButton(onPressed: (){}, icon: Image.asset(AppImages.iconNotifications,height: 27,)),
      const SizedBox(width: 10,),
      Row(children: [
        Container(
          height: 40,
            width: 40,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              shape: BoxShape.circle
            ),
            child: Image.asset(AppImages.romaReigns,fit: BoxFit.cover,)),
        Container(
          width: 170,
          margin: const EdgeInsets.only(right: 20,left: 6),
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
           Text('Ali Hamza',style: AppTextStyles.workSans(color: AppColors.grey3B3B3B, fontSize: 13, weight: FontWeight.w600),),
           Text('alihamza2334@gmail.com',style: AppTextStyles.workSans(color: AppColors.grey3B3B3B.withOpacity(0.7), fontSize: 12, weight: FontWeight.w400)),
               ],),
        )
      ],),

      ],),
    );
  }

  //
  // Widget recentUsers(){
  //   return Container(
  //     height: size!.height*0.78,
  //     width: size!.width*0.58,
  //     decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(18),
  //         boxShadow: [BoxShadow(color: Colors.grey,),]
  //     ),
  //     child:Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         SizedBox(height: 5,),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: [
  //             Text('  Recent Orders',style: TextStyle(fontSize: size!.width*0.01,fontWeight: FontWeight.bold,color: AppColors.primary),),
  //             const Text(''),
  //             const Text(''),
  //             const Text(''),
  //             ElevatedButton(onPressed: (){}, child: Text('View All',style: TextStyle(fontSize: size!.width*0.01,fontWeight: FontWeight.bold,color: Colors.white),),),
  //
  //           ],),
  //         Container(height: size!.height*0.73,
  //             child: Column(children: [
  //               SizedBox(height: size!.height*0.04,),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                 children: [
  //                   Text('Name',style: TextStyle(fontSize: size!.width*0.01,fontWeight: FontWeight.bold),),
  //                   Text(''),
  //                   Text('Price',style: TextStyle(fontSize: size!.width*0.01,fontWeight: FontWeight.bold),),
  //                   Text('Payement',style: TextStyle(fontSize: size!.width*0.01,fontWeight: FontWeight.bold),),
  //                   Text('Status',style: TextStyle(fontSize: size!.width*0.01,fontWeight: FontWeight.bold),),
  //
  //                 ],),
  //               SizedBox(height: size!.height*0.03,),
  //               // StreamBuilder(
  //               //   stream:FirebaseFirestore.instance.collection('orders').orderBy('date',descending: true).snapshots() ,
  //               //   builder: (context,snapshot){
  //               //     if (!snapshot.hasData) {
  //               //       return SpinKitCircle(color:appcolor,);
  //               //     }
  //               //     var data=snapshot.data!.docs;
  //               //     return data.isEmpty ? Center(child: Text('No Orders'),):ListView.builder(
  //               //       itemCount:data.length ,
  //               //       itemBuilder: (context,index){
  //               //         dynamic date='${data[index]['date']}'.split(' ');
  //               //         date=date[0];
  //               //         return ListTile(
  //               //           leading: Container(
  //               //               width: 100,
  //               //               height: 100,
  //               //               clipBehavior: Clip.antiAlias,
  //               //               decoration: BoxDecoration(
  //               //                   shape: BoxShape.circle
  //               //               ),
  //               //               child: Image.network('${data[index]['profileurl']}')),
  //               //           title: Text('${data[index]['name']}'),
  //               //           subtitle: Text(date),
  //               //         );
  //               //       },
  //               //     );
  //               //   },
  //               // ),
  //             ],)
  //         )
  //       ],),
  //   );
  // }

}

