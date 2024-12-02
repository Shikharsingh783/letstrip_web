import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MobileDialog extends StatelessWidget {
  const MobileDialog({
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
                Stack(
                  children: [
                    Image.asset(
                      'assets/Group 1000008021.png',
                      height: 131,
                      width: 280,
                    ),
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Image.asset(
                          'assets/Group 1000008019.png',
                          height: 66,
                        )),
                    Positioned(
                        top: 10,
                        right: 10,
                        child: Image.asset(
                          'assets/Group (1).png',
                          height: 66,
                        )),
                    Positioned(
                        top: 30,
                        right: 10,
                        child: Image.asset(
                          'assets/Group 1000008020.png',
                          height: 66,
                        )),
                    Positioned(
                        top: 50,
                        left: 10,
                        child: Image.asset(
                          'assets/Group (2).png',
                          height: 66,
                        )),
                  ],
                ),
                Text(
                  "Congratulations",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.raleway(
                      color: const Color.fromRGBO(57, 185, 111, 1),
                      fontWeight: FontWeight.w700,
                      fontSize: 21),
                ),
                const SizedBox(height: 12),
                Text(
                  "You have 3 months subscription\n has begun!!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.raleway(
                      color: const Color.fromRGBO(102, 102, 102, 1),
                      fontWeight: FontWeight.w700,
                      fontSize: 12),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(57, 185, 111, 1),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Text(
                      "Lets's Go",
                      style: GoogleFonts.raleway(
                          fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset('assets/Group 1000008017.png')))
          ],
        ),
      ),
    );
  }
}
