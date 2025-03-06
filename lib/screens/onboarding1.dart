import 'package:flutter/material.dart';

class OnBoarding1 extends StatefulWidget {
  final String image;
  final String title;
  final String description;

  const OnBoarding1(
      {required this.image,
      required this.title,
      required this.description,
      super.key});

  @override
  State<OnBoarding1> createState() => _OnBoarding1State();
}

class _OnBoarding1State extends State<OnBoarding1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(widget.image),
          SizedBox(
            height: 20),
          Text(
            widget.title,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.description,
              textAlign: TextAlign.left,
              maxLines: 2,
              style: TextStyle(fontSize: 18, color: Color(0xFF71727A)),
            ),
          ),
        ],
      ),
    );
  }
}
