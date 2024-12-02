import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DesktopDialog extends StatelessWidget {
  const DesktopDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.transparent, // Make background transparent
      child: Container(
        height: w * 0.3,
        width: w * 0.5,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                // Left, center, and right images
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.03),
                          child: Image.asset(
                            'assets/Group 1000008026.png',
                            height: w * 0.1,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(height: w * 0.02),
                        Image.asset(
                          'assets/Group (3).png',
                          height: w * 0.03,
                          fit: BoxFit.fill,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: w * 0.02),
                      child: Image.asset(
                        'assets/Group 1000008024.png',
                        height: w * 0.13,
                        width: w * 0.15,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/Group (4).png',
                          height: w * 0.03,
                          fit: BoxFit.fill,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: w * 0.02, top: 35),
                          child: Image.asset(
                            'assets/Group 1000008025.png',
                            height: w * 0.1,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  "Congratulations",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.raleway(
                    color: const Color.fromRGBO(57, 185, 111, 1),
                    fontWeight: FontWeight.w700,
                    fontSize: w * 0.02,
                  ),
                ),
                SizedBox(height: w * 0.001),
                Text(
                  "Your 3-month subscription has begun!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.raleway(
                    color: const Color.fromRGBO(111, 108, 144, 1),
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: w * 0.5,
                  height: w * 0.035,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(57, 185, 111, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Let's Go",
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Image.asset('assets/Group 1000008017.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
