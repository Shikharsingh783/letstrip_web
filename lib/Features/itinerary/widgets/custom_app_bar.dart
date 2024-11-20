import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize =>
      const Size.fromHeight(80); // Set the preferred height for the app bar

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            blurRadius: 8, // Blur radius of the shadow
            spreadRadius: 2, // Spread radius of the shadow
          ),
        ],
      ),
      child: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20),
          child: Row(
            children: [
              Image.asset(
                'assets/unnamed 1.png',
                height: 35,
              ),
            ],
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  // Navigate to Home screen
                },
                child: const Text('Home',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
              ),
              const SizedBox(width: 20),
              TextButton(
                onPressed: () {
                  // Navigate to Recommendation screen
                },
                child: const Text('Recommendation',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
              ),
              const SizedBox(width: 20),
              TextButton(
                onPressed: () {
                  // Navigate to Itinerary screen
                },
                child: const Text('Itinerary',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
              ),
              const SizedBox(width: 20),
              TextButton(
                onPressed: () {
                  // Navigate to About Us screen
                },
                child: const Text('About Us',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              children: [
                Container(
                    width: 199,
                    height: 46,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Download App',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'redHat',
                              color: Colors.white),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Image.asset(
                          'assets/Vector.png',
                          height: 18,
                          width: 18,
                        )
                      ],
                    )),
                const SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40.0),
                  child: Container(
                    height: 40, // Set height for visibility
                    width: 40, // Set width for the circle
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/Group 166.png'),
                        fit: BoxFit
                            .cover, // Ensure the image fits inside the circle
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
