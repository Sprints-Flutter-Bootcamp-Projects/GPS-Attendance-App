import 'package:flutter/material.dart';
import 'package:gps_attendance/features/onboarding/presentation/widgets/horizontal_card.dart';

class OnBoarding2 extends StatefulWidget {
  final String image;
  final String title;

  const OnBoarding2({required this.image, required this.title, super.key});

  @override
  State<OnBoarding2> createState() => _OnBoarding2State();
}

class _OnBoarding2State extends State<OnBoarding2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(widget.image),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    horizontalCard(
                      'Location-Precise Tracking',
                      'Verify employee presence within designated work zones automatically',
                    ),
                    const SizedBox(height: 10),
                    horizontalCard(
                      'Work from Anywhere',
                      'Track attendance seamlessly across Android and iOS devices',
                    ),
                    const SizedBox(height: 10),
                    horizontalCard(
                      'Intelligent Insights',
                      'Generate comprehensive reports and visualize attendance patterns',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
