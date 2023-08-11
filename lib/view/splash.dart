import 'package:flutter/material.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/constants/images.dart';
import 'package:weather_app/view/home_page.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: Future.delayed(const Duration(seconds: 1)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    AppImages.appSplashIcon,
                    height: 400,
                    width: 400,
                  ),
                  const SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      color: AppColors.bright,
                      strokeWidth: 2,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const HomePage();
          }
        },
      ),
    );
  }
}
