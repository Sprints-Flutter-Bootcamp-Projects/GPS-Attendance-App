import 'package:flutter/material.dart';

class OnBoarding3 extends StatefulWidget {
  final String image;
  final String title;
  final String description;

  const OnBoarding3(
      {required this.image,
      required this.title,
      required this.description,
      super.key});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: screenWidth,
              height: screenWidth / 1.5,
              child: Image.asset(
                widget.image,
                fit: BoxFit.cover,
              )),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: 10),
                Text(
                  widget.description,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 16, color: Color(0xFF71727A)),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      progress('1', 'Accuracy'),
                      progress('2', 'Efficiency'),
                      progress('3', 'Flexibility')
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget progress(String number, String progress) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              "assets/images/Background.png",
              width: 100,
              height: 100,
            ),
            Text(
              number,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
        Text(
          progress,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
