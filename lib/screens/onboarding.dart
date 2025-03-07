import 'package:flutter/material.dart';
import 'package:gps_attendance/core/utils/app_colors.dart';
import 'package:gps_attendance/screens/login_screen.dart';
import 'package:gps_attendance/screens/onboarding1.dart';
import 'package:gps_attendance/screens/onboarding2.dart';
import 'package:gps_attendance/screens/onboarding3.dart';
import 'package:gps_attendance/widgets/nice_button.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: [
                  OnBoarding1(
                    image: 'assets/images/onboarding1.png',
                    title: 'Smart Attendance Tracking',
                    description:
                        'Simplify your workplace attendance. Stay connected, stay productive.',
                  ),
                  OnBoarding2(
                    image: 'assets/images/onboarding2.png',
                    title: 'Key Features',
                  ),
                  OnBoarding3(
                    image: 'assets/images/onboarding3.png',
                    title: 'Welcome to TrackSync',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentIndex == index ? 20 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentIndex == index
                          ? AppColors.primaryColor
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 5.0),
            niceButton(
              title: _currentIndex == 2 ? 'Get Started' : 'Next',
              onTap: () {
                if (_currentIndex == 2) {
                  // Navigate to login screen when onboarding is done
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                } else {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
