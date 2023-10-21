import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:wssal/core/utils/color_utils.dart';
import 'package:wssal/core/widgets/global_scaffold.dart';
import 'package:wssal/features/auth/login/screens/login_screen.dart';
class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GlobalScaffold(
      body: OnBoardingSlider(
        headerBackgroundColor: Colors.white,
        pageBackgroundColor: Colors.white,
        finishButtonText: 'تسجيل دخول',
        finishButtonColor: AppColors.primaryColor,
        finishButtonTextStyle:
            const TextStyle(fontSize: 16, color: Colors.white),
        skipTextButton: const Text(
          'تخطي',
          style: TextStyle(
            fontSize: 18,
            color: AppColors.thirdColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        controllerColor: Colors.orange,
        totalPage: 3,
        speed: 1.8,
        onFinish: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const LoginScreen();
              },
            ),
          );
        },
        pageBodies: const [
          SizedBox.shrink(),
          SizedBox.shrink(),
          SizedBox.shrink(),
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 40),
          //   child: Column(
          //     children: <Widget>[
          //       SizedBox(
          //         height: MediaQuery.of(context).size.height / 2,
          //       ),
          //       const Text(
          //         'بوابتك الإلكترونية\nلانتقاء بضاعتك بكل سهولة',
          //         textAlign: TextAlign.center,
          //         style: TextStyle(
          //           fontSize: 18,
          //           fontWeight: FontWeight.w500,
          //           color: AppColors.thirdColor,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 40),
          //   child: Column(
          //     children: <Widget>[
          //       SizedBox(
          //         height: MediaQuery.of(context).size.height / 2,
          //       ),
          //       const Text(
          //         'بوابتك الإلكترونية\nلتشكيل سلعي عالي التميز',
          //         textAlign: TextAlign.center,
          //         style: TextStyle(
          //           fontSize: 18,
          //           fontWeight: FontWeight.w500,
          //           color: AppColors.thirdColor,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 40),
          //   child: Column(
          //     children: <Widget>[
          //       SizedBox(
          //         height: MediaQuery.of(context).size.height / 2,
          //       ),
          //       const Text(
          //         'بوابتك الإلكترونية\nلشحن وتوصيل بضاعتك',
          //         textAlign: TextAlign.center,
          //         style: TextStyle(
          //           fontSize: 18,
          //           fontWeight: FontWeight.w500,
          //           color: AppColors.thirdColor,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
        background: [
          Image.asset('assets/images/on-boarding-1.jpg',
              height: MediaQuery.of(context).size.height*0.8,
              width: MediaQuery.of(context).size.width),
          Image.asset('assets/images/on-boarding-2.jpg',
              height: MediaQuery.of(context).size.height*0.8,
              width: MediaQuery.of(context).size.width),
          Image.asset('assets/images/on-boarding-3.jpg',
              height: MediaQuery.of(context).size.height*0.8,
              width: MediaQuery.of(context).size.width),
        ],
      ),
    );
  }
}
