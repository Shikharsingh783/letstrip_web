// import 'package:flutter/material.dart';
// import 'package:letstrip/utils/shared_pref.dart';

// /// global navigation key
// GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// class LetsTripApp extends StatefulWidget {
//   const LetsTripApp({super.key});

//   @override
//   LetsTripAppState createState() => LetsTripAppState();
// }

// class LetsTripAppState extends State<LetsTripApp> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     /// initializing the screen unit library and
//     /// setting up the design width and height
//     return ScreenUtilInit(
//       designSize: MediaQuery.of(context).size.width > 600
//           ? const Size(834, 1112)  // iPad (7th gen) design size, you can update this
//           : const Size(375, 812),
//       minTextAdapt: true,
//       builder: (context, child) {
//         return GetMaterialApp(
//           ///Remove Debug tag from top right corner
//           debugShowCheckedModeBanner: false,

//           ///setup navigation key
//           navigatorKey: navigatorKey,

//           ///Light theme of the app
//           theme: AppTheme.lightTheme,

//           ///Dark theme of the app
//           darkTheme: AppTheme.darkTheme,

//           /// current theme mode of app
//           themeMode: ThemeMode.light,

//           /// setting up localisation delegates for the app
//           localizationsDelegates: const [
//             S.delegate,
//             GlobalMaterialLocalizations.delegate,
//             GlobalWidgetsLocalizations.delegate,
//             GlobalCupertinoLocalizations.delegate,
//           ],

//           /// this line set up the languages we use in our app
//           supportedLocales: S.delegate.supportedLocales,
//           locale: const Locale('en'),

//           /// app home page
//           home: buildAppHome(),
//         );
//       },
//     );
//   }

//   buildAppHome() {
//     switch (SharedPref.getString(initialScreen) ?? "welcomeScreen") {
//       case "welcomeScreen":
//         return const LoginScreen();
//       case "loginScreen":
//         return const LoginScreen();
//       case "registrationScreen":
//         return const RegistrationScreen();
//       default:
//         return const BottomBarScreen();
//     }
//   }
// }
