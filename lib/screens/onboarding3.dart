import 'package:flutter/material.dart';

class OnBoarding3 extends StatefulWidget {
  final String image;
  final String title;


  
  const OnBoarding3(
      {
      required this.image,
      required this.title,
      super.key
      });

  @override
  State<OnBoarding3> createState() => _OnBoarding3State();
}

class _OnBoarding3State extends State<OnBoarding3> {
  
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: screenWidth,
            height: screenWidth/1.5,
            child: Image.asset(widget.image,
            fit: BoxFit.cover,)),
          SizedBox(
          height: 20,
          // width: MediaQuery.of(context).size.width
          ),
          Text(
            widget.title,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(height: 10),
          // Text(
          //   widget.description,
          //   textAlign: TextAlign.start,
          //   style: TextStyle(fontSize: 16),
          // ),
          Center(
            
          )
        ],
      ),
    );
  }
}