import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:unity_web_app/main.dart';
import 'package:unity_web_app/utilis/app_constants.dart';
import 'package:unity_web_app/utilis/app_preferences.dart';
import 'package:unity_web_app/utilis/app_text_styles.dart';
import 'package:unity_web_app/view_model/reset_password_bloc/reset_password_bloc.dart';
import 'package:unity_web_app/view_model/verify_otp_bloc/verify_otp_bloc.dart';
import '../../network/api_params.dart';
import '../../utilis/app_colors.dart';
import '../../utilis/app_images.dart';
import '../../view_model/api_calls.dart';
import '../date_formatting.dart';



class OTPDialog extends StatefulWidget {
  final String? phone;
  final String check;
  const OTPDialog({
    Key? key,
    this.phone,
    required this.check,
  }) : super(key: key);

  @override
  _OTPDialogState createState() => _OTPDialogState();
}

class _OTPDialogState extends State<OTPDialog> {
  final TextEditingController _otpController = TextEditingController();
  late StreamController<int> _streamController;
  late StreamController<int> _requestAginController;
  int _remainingSeconds = 120;
  final FocusNode _pinPutFocusNode = FocusNode();


  @override
  void initState() {
    super.initState();
    _streamController = StreamController<int>();
    _requestAginController=StreamController<int>();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return  Center(
      child: SizedBox(
        width:size.width<520 ?size.width*0.8 :size.width*0.35,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _body()
          ],
        ),
      ),
    );
  }

  Widget _body(){
    return SingleChildScrollView(
      child: Dialog(
        backgroundColor: AppColors.pureWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 16,
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Stack(
              children: [
                Container(color: AppColors.pureWhite,),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20,),
                    Image.asset(AppImages.iconLogo,height: 44,),
                    const SizedBox(height: 10,),
                    Text(AppConstants.otpVerification,style:  AppTextStyles.raleWay(color: AppColors.black000000, fontSize: 18, weight: FontWeight.w600),textAlign: TextAlign.center),
                    Text(AppConstants.otpVerifyDescription,style:  AppTextStyles.raleWay(color: AppColors.black000000, fontSize: 13, weight: FontWeight.w500),textAlign: TextAlign.center),
                    const SizedBox(height: 30,),
                    inputField(),
                    const SizedBox(height: 20,),
                    Text(AppConstants.timeRemainig,),
                    StreamBuilder(stream: _streamController.stream, builder: (contex,snap){
                      if(ConnectionState.waiting==snap.connectionState){
                        return Text(FormatDates.formatDuration(_remainingSeconds),style: AppTextStyles.gotham(color: AppColors.primary, fontSize: 14, weight: FontWeight.w600),);
                      }
                      return Text(FormatDates.formatDuration(snap.data!),style: AppTextStyles.gotham(color: AppColors.primary, fontSize: 14, weight: FontWeight.w600),);
                    }),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.resolveWith((states) => AppColors.primary),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side:  BorderSide(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if(_otpController.text.length!=4){
                                  return;
                                }
                                context.read<VerifyOtpBloc>().add(VerifyOtpApiEvent({Params.email:widget.check,Params.verifyOtp:_otpController.text},context));

                              },
                              child: Text(AppConstants.verify,style:  AppTextStyles.raleWay(color: AppColors.whiteFFFFFF, fontSize: 14, weight: FontWeight.w600),textAlign: TextAlign.center),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppConstants.didntRecieveCode,style: AppTextStyles.raleWay(color: AppColors.black000000, fontSize: 12, weight: FontWeight.w600),),
                        StreamBuilder(stream: _requestAginController.stream, builder: (contex,snap){
                          if(snap.connectionState==ConnectionState.waiting){
                            return const Text('');
                          }
                          return  snap.data==0 ?  TextButton(onPressed: () async {
                            bool result=await  ApiCalls.sendOtp(map: {Params.email:widget.check});
                            if(result){
                              _remainingSeconds=120;
                              _startTimer();
                            }

                          }, child: Text( AppConstants.requestAgain,style: AppTextStyles.gotham(color:  AppColors.primary, fontSize: 13, weight: FontWeight.w600),)):const Text('');
                        })

                      ],),
                    const SizedBox(height: 20,),
                  ],
                ),
                Positioned(
                  right: 0,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void _startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        _requestAginController.add(_remainingSeconds);
        _streamController.add(_remainingSeconds);
      } else {
        timer.cancel();
        // Do something when the timer is done
      }
    });
  }


  Padding inputField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Pinput(
        // androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
        controller: _otpController,
        length: 4,
        pinAnimationType: PinAnimationType.slide,
        followingPinTheme: PinTheme(
            width: 40,height: 40,
            textStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
            decoration: pinPutDecoration
        ),
        defaultPinTheme: PinTheme(
            width: 40,height: 40,
            textStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
            decoration: pinUnSubmitDecoration
        ),
        focusedPinTheme: PinTheme(
            width: 40,height: 40,
            textStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
            decoration: pinUnSubmitDecoration
        ),
      ),
    );
  }


  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: AppColors.primary.withOpacity(0.2),
    borderRadius: BorderRadius.circular(5),
    border: Border.all(
      color: AppColors.whiteFFFFFF,
    ),
  );
  final BoxDecoration pinUnSubmitDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(5),
    border: Border.all(
      color: AppColors.primary,
    ),
  );



  @override
  void dispose() {
    _streamController.close();
    _requestAginController.close();
    super.dispose();
  }

}