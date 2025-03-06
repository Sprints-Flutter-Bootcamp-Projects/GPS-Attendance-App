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
        children: [
          Image.asset(widget.image),
          SizedBox(height: 20),
          Text(
            widget.title,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFF8F9FE), // Background color
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox(
                  child: Row(
                children: [
                  Image.asset('assets/images/HeartFilled.png'),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Location-Precise Tracking',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Verify employee presence within designated work zones automatically',
                          maxLines: 2,
                          softWrap: true,
                          style: TextStyle(color: Color(0xFF71727A)),
                        ),
                      )
                    ],
                  )
                ],
              )),
            ),
          )
        ],
      ),
    );
  }
}
