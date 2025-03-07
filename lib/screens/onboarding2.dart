import 'package:flutter/material.dart';

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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(widget.image),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10.0),
            child: Text(
              widget.title,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          SizedBox(height: 10),
          horizontalCard('Location-Precise Tracking',
              'Verify employee presence within designated work zones automatically'),
          SizedBox(height: 10),
          horizontalCard('Work from Anywhere',
              'Track attendance seamlessly across Android and iOS devices'),
          SizedBox(height: 10),
          horizontalCard('Intelligent Insights',
              'Generate comprehensive reports and visualize attendance patterns'),
        ],
      ),
    );
  }

  Widget horizontalCard(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF8F9FE), // Background color
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
            child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child:
                  SizedBox(child: Image.asset('assets/images/HeartFilled.png')),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      title,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ClipRRect(
                      child: Text(
                        subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(color: Color(0xFF71727A)),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
