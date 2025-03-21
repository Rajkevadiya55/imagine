import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imagine/common/image_constant/image_constant.dart';
import 'package:imagine/helper/helper.dart';
import 'package:imagine/router/app_router.dart';
import 'package:imagine/services/messaging_service.dart';
import 'package:imagine/view/login_view/login_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  // final messagigng = MessagingService();

  @override
  void initState() {
    super.initState();
    // Set a timer for 2 seconds
    // messagigng.init(context);
    Timer(const Duration(seconds: 2), () {
      AppRouter.navigatorKey.currentState?.pushNamed(
        AppRouter.login,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppIcons.app_logo),
            SizedBox(
              height: 30,
            ),

            // Add any additional splash screen content here
          ],
        ),
      ),
    );
  }
}
