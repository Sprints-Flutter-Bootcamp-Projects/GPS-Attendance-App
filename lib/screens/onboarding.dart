import 'package:flutter/material.dart';
import 'package:gps_attendance/screens/login_screen.dart';
import 'package:gps_attendance/screens/onboarding1.dart';
import 'package:gps_attendance/screens/onboarding2.dart';
import 'package:gps_attendance/screens/onboarding3.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView for onboarding screens
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              OnBoarding1(
                image: 'assets/images/onboarding1.png',
                title: 'Smart Attendance Tracking',
                description: 'Simplify your workplace attendance Stay connected, stay productive',
              ),
              OnBoarding2(
                image: 'assets/images/onboarding2.png',
                title: 'Key Features',
                // description: 'Find new and exciting functionalities.',
              ),
              OnBoarding3(
                image: 'assets/images/onboarding3.png',
                title: 'Welcome to TrackSync',
                // description: 'Let\'s dive right in and enjoy the experience!',
              ),
            ],
          ),
          // Dots indicator
          Positioned(
            top: 350,
            left: 0,
            right: 400,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: _currentPage == index ? 12 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? Color(0xFF1A96B1) : Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
          ),
          //  Next and get started button
          Positioned(
            width: 450,
            height: 50,
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 26, 150, 177), // Button color
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
              ),
              onPressed: () {
                if (_currentPage == 2) {
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
              child: Text(_currentPage == 2 ? 'Get Started' : 'Next',
              style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}


