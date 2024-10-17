// ignore_for_file: file_names

dynamic image(dynamic type){
  print (type);
 switch(type){
 case "clear":
 return "assets/cloudy.png";
 case "clouds":
 return "assets/clouds.png";
 case "lightning":
  return "assets/storm.png";
 case "mist": 
  return  "assets/fog.png";

 case "rain":
  return "assets/rainy-day.png";
  default:
  return "assets/cloudy.png";
 }
}

