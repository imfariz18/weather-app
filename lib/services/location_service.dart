// ignore_for_file: body_might_complete_normally_nullable, avoid_print

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService{
Future<Placemark?>getLocationName(Position?position)async{
if(position!=null){

try{
final placemarks=await placemarkFromCoordinates(position.latitude,position.longitude);
if(placemarks.isNotEmpty){
  return placemarks[0];
}
}


catch(e){
print("error finding the location");
}

return null;
}

}


}