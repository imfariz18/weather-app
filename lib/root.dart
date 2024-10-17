import 'package:flutter/material.dart';
import 'package:newweather/Homescreen.dart';
import 'package:newweather/routes.dart';
import 'package:newweather/splashscreen.dart';



class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splashscreen,
      routes: {
        Routes.splashscreen: (context) => const Splashscreen(),
        Routes.homeScreen: (context) => const HomeScreen(),
      },
    );

  }
}