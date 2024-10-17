import 'package:flutter/material.dart';
import 'package:newweather/routes.dart';


class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}



class _SplashscreenState extends State<Splashscreen> {
  
  @override
  void initState() {
    
    super.initState();
    Future.delayed(const Duration(seconds: 6),()async{
      Navigator.pushNamed(context, Routes.homeScreen);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
   
      child: Stack(
        children: [
          // ColorFiltered(colorFilter: ColorFilter.mode(Colors.blue.withOpacity(0.6),BlendMode.srcOver)),
          Container(
            decoration: const BoxDecoration(
            
                // image: DecorationImage(
                //     image: AssetImage(
                //       "assets/background.jpg",
                //     ),
                //     fit: BoxFit.cover)
               gradient: LinearGradient(colors: [Color.fromARGB(255, 176, 198, 238),Color.fromARGB(255, 141, 213, 217)],begin: Alignment.topCenter,end:Alignment.bottomCenter ), ),
          ),
           Positioned(
            top: 300,
            left: 60,
            child:Container(
              height: 250,
              width: 250,
              decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/logo1.png"))),
            )
          ),
        ],
      ),
    ),
    );
    
  }
}