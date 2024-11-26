import 'package:flutter/material.dart';
import 'package:letstrip/utils/navigation.dart';

class ResultScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ResultScreenAppBar({
    super.key,
  });

  @override
  Size get preferredSize =>
      const Size.fromHeight(100); // Adjust the height as needed

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: preferredSize.height,
      decoration: const BoxDecoration(
        color: Colors.white, // Set background color
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_sharp)),
            // Left Section
            // const Text(
            //   'Itinerary',
            //   style: TextStyle(
            //     fontFamily: 'redHat',
            //     fontSize: 25,
            //     fontWeight: FontWeight.w900,
            //   ),
            // ),

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
