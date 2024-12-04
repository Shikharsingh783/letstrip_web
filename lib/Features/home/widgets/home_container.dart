import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:letstrip/Features/home/widgets/box.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:video_player/video_player.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({super.key});

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  late VideoPlayerController _videoController;
  bool _isVideoInitialized = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();

    // Initialize the video controller
    _videoController = VideoPlayerController.network(
      'https://res.cloudinary.com/ddyyltrso/video/upload/v1733332886/s59lv7kdze4z0pbl9amm.mp4',
    )..initialize().then((_) {
        setState(() {
          _isVideoInitialized = true;
          _videoController.setLooping(true); // Loop the video
          _videoController.play(); // Start playing the video
        });
      }).catchError((error) {
        setState(() {
          _hasError = true;
        });
        print('Error initializing video: $error');
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenTypeLayout.builder(
        desktop: (context) => desktopContainer(),
      ),
    );
  }

  Widget desktopContainer() {
    return SingleChildScrollView(
      child: Column(
        children: [
          videoPage(),
          secondPage(),
        ],
      ),
    );
  }

  Widget videoPage() {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Video background
          _isVideoInitialized
              ? Align(
                  alignment: Alignment.center,
                  child: Transform.scale(
                    scale: 1.34, // Adjust this scale value to zoom in/out
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: VideoPlayer(_videoController),
                    ),
                  ),
                )
              : _hasError
                  ? Center(child: Text('Failed to load video'))
                  : const Center(child: CircularProgressIndicator()),

          // Overlay for content
          Container(
            color: Colors.black.withOpacity(0.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Heading
                Text(
                  "Let's get travelling.\nDiscover. Plan. Enjoy.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.redHatDisplay(
                    fontSize: 60,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                // Subheading
                Text(
                  'Powered by millions of real travel reviews and insights',
                  style: GoogleFonts.raleway(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                // Image
                Image.asset(
                  'assets/featured 1 (1).png',
                  scale: 2,
                ),
                const SizedBox(height: 40),
                // Features
                const Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 30,
                  runSpacing: 20,
                  children: [
                    Box(
                      title: 'Recommendation',
                      description:
                          'Get destination recommendations based on your budget and type of trip',
                    ),
                    Box(
                      title: 'Itinerary',
                      description:
                          'Create a completely personalized itinerary for your next trip in 10 seconds',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget secondPage() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          width: screenWidth,
          height: screenHeight,
          color: Colors.white,
        ),
        Positioned(
            top: screenWidth * 0.03,
            left: screenWidth * 0.07,
            child: Text(
              'Your Packing\nAssistant',
              style: GoogleFonts.redHatDisplay(
                fontSize: 60,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            )),
        Positioned(
            top: screenWidth * 0.03,
            right: screenWidth * 0.13,
            child: Image.asset('assets/Phone mockup 1.png')),
        Positioned(
            top: screenWidth * 0.17,
            left: screenWidth * 0.08,
            child: Image.asset('assets/Group 1000002091.png')),
        Positioned(
            top: screenWidth * 0.16,
            left: screenWidth * 0.1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Personlised Packing Lists',
                  style: GoogleFonts.raleway(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Tailored to your trip specifics.',
                  style: GoogleFonts.raleway(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(102, 102, 102, 1),
                  ),
                ),
              ],
            )),
        Positioned(
            top: screenWidth * 0.23,
            left: screenWidth * 0.1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Checklists',
                  style: GoogleFonts.raleway(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Ensure you have everything you need.',
                  style: GoogleFonts.raleway(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(102, 102, 102, 1),
                  ),
                ),
              ],
            )),
        Positioned(
            top: screenWidth * 0.295,
            left: screenWidth * 0.1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Trips and Tricks',
                  style: GoogleFonts.raleway(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Packing hacks to save space and time.',
                  style: GoogleFonts.raleway(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(102, 102, 102, 1),
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
