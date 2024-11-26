import 'package:flutter/material.dart';

class MobileAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MobileAppbar({
    super.key,
  });

  @override
  Size get preferredSize =>
      const Size.fromHeight(700); // Adjust the height as needed

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: preferredSize.height,
      decoration: const BoxDecoration(
        color: Colors.white, // Set background color
        // border: Border(
        //   bottom: BorderSide(
        //     color: Color.fromRGBO(57, 185, 111, 1), // Divider color
        //     width: 3, // Divider thickness
        //   ),
        // ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left Section
            const Text(
              'Recommendation',
              style: TextStyle(
                fontFamily: 'redHat',
                fontSize: 25,
                fontWeight: FontWeight.w900,
              ),
            ),

            // Right Section
            Container(
              height: 40, // Set height for visibility
              width: 40, // Set width for the circle
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/Group 166.png'),
                  fit: BoxFit.cover, // Ensure the image fits inside the circle
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
