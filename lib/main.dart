import 'package:flutter/material.dart';
import 'package:newweather/root.dart';
import 'package:newweather/services/locationProvidr.dart';
import 'package:newweather/services/WeatherServiceProvider.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: 
 [
  ChangeNotifierProvider(create: (context)=>LocationProvider(),),
  ChangeNotifierProvider(create: (context)=>WeatherServiceprovider())
 ],
 child:const Root(),
  ));
}

