import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newweather/Apptext.dart';
import 'package:newweather/img.dart';
import 'package:newweather/services/WeatherServiceProvider.dart';
import 'package:newweather/services/locationProvidr.dart';

import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController cityController = TextEditingController();
  bool clicked = false;

  @override
  void initState() {
    super.initState();
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    locationProvider.determinePosition().then((_) {
      if (locationProvider.currentLocationName != null) {
        var city = locationProvider.currentLocationName!.locality;
        if (city != null) {
          Provider.of<WeatherServiceprovider>(context, listen: false)
              .fetchWeatherDataByCity(city);
        }
      }
    });
  }

  @override
  void dispose() {
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherServiceprovider>(context);

    String formattedSunrise = _formatTime(weatherProvider.weather?.sys?.sunrise ?? 0);
    String formattedSunset = _formatTime(weatherProvider.weather?.sys?.sunset ?? 0);

    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 192, 196, 198),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 15, right: 10),
              child: Column(
                children: [
                  _buildLocationRow(context),
                  const SizedBox(height: 5),
                  clicked ? _buildSearchBar(weatherProvider) : const SizedBox.shrink(),
                  const SizedBox(height: 20),
                  _buildWeatherInfo(weatherProvider),
                  const SizedBox(height: 20),
                  _buildWeatherDetails(weatherProvider, formattedSunrise, formattedSunset),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationRow(BuildContext context) {
    //final locationProvider = Provider.of<LocationProvider>(context);

    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Consumer<LocationProvider>(
        builder: (context, locationProvider, child) {
          var locationCity = locationProvider.currentLocationName?.administrativeArea ?? "Unknown location";

          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_pin, color: Colors.red, size: 40),
              const SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(data: locationCity, color: Colors.black87, fw: FontWeight.bold, size: 20),
                  AppText(data: DateFormat("hh:mm a").format(DateTime.now()), color: Colors.black87, size: 15),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  setState(() {
                    clicked = !clicked;
                  });
                },
                icon: const Icon(Icons.manage_search, size: 35, color: Colors.black),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSearchBar(WeatherServiceprovider weatherProvider) {
  final locationProvider = Provider.of<LocationProvider>(context, listen: false);
  return Container(
    height: 40,
    width: 400,
    color: Colors.white,
    child: Row(
      children: [
       
        Expanded(
          child: TextFormField(
            textAlign: TextAlign.center,
            controller: cityController,
            decoration: const InputDecoration(
              hintText: "Search City",
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            ),
          ),
        ),
        IconButton(
          onPressed: () async {
            String city = cityController.text.trim();
            if (city.isNotEmpty) {
              await weatherProvider.fetchWeatherDataByCity(city);
              locationProvider.updateLocation(city);
              setState(() {
                clicked = false; // Hide search bar after search
              });
            }
          },
          icon: const Icon(Icons.search, color: Colors.black),
        ),
       
      ],
    ),
  );
}


  Widget _buildWeatherInfo(WeatherServiceprovider weatherProvider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 150,
          width: 150,
          child: Image.asset(image(weatherProvider.weather?.weather?.first.main?.toLowerCase() ?? '')),
        ),
        const SizedBox(height: 15),
        AppText(
          data: "${weatherProvider.weather?.main?.temp?.toStringAsFixed(0)}\u00B0 C",
          color: Colors.black87,
          fw: FontWeight.w900,
          size: 40,
        ),
        const SizedBox(height: 5),
        AppText(
          data: weatherProvider.weather?.name ?? "N/A",
          color: Colors.black87,
          fw: FontWeight.bold,
          size: 22,
        ),
        const SizedBox(height: 5),
        AppText(
          data: weatherProvider.weather?.weather?.first.main ?? "N/A",
          color: Colors.black87,
          fw: FontWeight.bold,
          size: 25,
        ),
      ],
    );
  }

  Widget _buildWeatherDetails(WeatherServiceprovider weatherProvider, String sunrise, String sunset) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildWeatherDetailItem(
              imagePath: "assets/thermometer.png",
              title: "Temp Max",
              value: "${weatherProvider.weather?.main?.tempMax?.toStringAsFixed(0) ?? "N/A"}\u00b0 C",
            ),
            _buildWeatherDetailItem(
              imagePath: "assets/low-temperature.png",
              title: "Temp Min",
              value: "${weatherProvider.weather?.main?.tempMin?.toStringAsFixed(0) ?? "N/A"}\u00b0 C",
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildWeatherDetailItem(
              imagePath: "assets/sun.png",
              title: "Sunrise",
              value: "$sunrise AM",
            ),
            _buildWeatherDetailItem(
              imagePath: "assets/moonlight.png",
              title: "Sunset",
              value: "$sunset PM",
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildWeatherDetailItem(
              imagePath: "assets/humidity.png",
              title: "Humidity",
              value: "${weatherProvider.weather?.main?.humidity ?? "N/A"}%",
            ),
            _buildWeatherDetailItem(
              imagePath: "assets/wind.png",
              title: "Wind",
              value: "${weatherProvider.weather?.wind?.speed?.toStringAsFixed(0) ?? "N/A"} Km/h",
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWeatherDetailItem({required String imagePath, required String title, required String value}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white70,
      ),
      height: 100,
      width: 180,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Image.asset(imagePath, height: 60),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppText(data: title, color: Colors.black87, fw: FontWeight.w900, size: 15),
                const SizedBox(height: 10),
                AppText(data: value, color: Colors.black87, size: 15),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(int timestamp) {
    return DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(timestamp * 1000));
  }
}
