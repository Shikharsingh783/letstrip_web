import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Box extends StatelessWidget {
  final String title;
  final String description;
  const Box({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenHeight * 0.55,
      height: screenWidth * 0.11,
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          SizedBox(
            height: screenWidth * 0.017,
          ),
          Text(
            title,
            style: GoogleFonts.redHatDisplay(
                fontSize: 30, fontWeight: FontWeight.w700, color: Colors.white),
          ),
          SizedBox(
            width: screenWidth * 0.2,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: GoogleFonts.raleway(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: screenWidth * 0.01,
          ),
          Image.asset('assets/Arrow 8.png')
        ],
      ),
    );
  }
}
