// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:weather_app_tutorial/consts.dart';
import 'package:weather_app_tutorial/widgets/display.dart';
import 'dart:convert';

import 'package:weather_app_tutorial/widgets/my_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.cityOnTap});

  @override
  _SearchScreenState createState() => _SearchScreenState();
  final String cityOnTap;
}

class _SearchScreenState extends State<SearchScreen> {
  var _weatherData;
  bool _loading = true;
  final TextEditingController _cityController = TextEditingController();


  @override
  void initState() {
    super.initState();
    fetchWeather(widget.cityOnTap);
  }

  Future<void> fetchWeather(String city) async {
    setState(() {
      _loading = true;
    });
    final response = await http.get(Uri.parse('$apiUrl?q=$city&appid=$apiKey'));
    if (response.statusCode == 200) {
      setState(() {
        _weatherData = json.decode(response.body);
        _loading = false;
      });
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Weather',
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 30,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.blue[300],
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _cityController,
                      decoration: InputDecoration(
                        labelText: 'Search for a city',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      fetchWeather(_cityController.text);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : WeatherDisplay(weatherData: _weatherData),
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherDisplay extends StatelessWidget {
  final Map weatherData;

  const WeatherDisplay({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    String iconCode = weatherData['weather'][0]['icon'];
    String iconUrl = 'http://openweathermap.org/img/wn/$iconCode@2x.png';

    String lottieAnimation =
        getWeatherAnimation(weatherData['weather'][0]['description']);

    return Container(
      color: Colors.blue[300],
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Display(
                city: '${weatherData['name']}',
                temp:
                    "${(weatherData['main']['temp'] - 273.15).toStringAsFixed(2)}°C",
                weather: '${weatherData['weather'][0]['description']}',
                iconPic: Lottie.asset(lottieAnimation),
                feelLike:
                    '${(weatherData['main']['feels_like'] - 273.15).toStringAsFixed(2)}°C',
                humidity: '${weatherData['main']['humidity']}%',
                pressure: '${weatherData['main']['pressure']} hPa',
                windSpeed: '${weatherData['wind']['speed']} m/s',
                windDirection: '${weatherData['wind']['deg']}°',
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getWeatherAnimation(String mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';
    switch (mainCondition.toLowerCase()) {
      ///////////// rain
      case 'rain':
      case 'drizzle':
      case 'light rain':
      case 'shower rain':
      case 'moderate rain':
      case 'heavy intensity rain':
      case 'very heavy rain':
        return 'assets/rain.json';

      ///////////// clear sky or sunny
      case 'clear sky':
      case 'sunny':
        return 'assets/sunny.json';

      ////////////// thunder
      case 'thunder':
      case "thunderstorm":
      case "light thunderstorm":
      case "heavy thunderstorm":
      case "ragged thunderstorm":
        return 'assets/thunder.json';

      ///////////// snowy
      case 'snowy':
      case 'light snow':
      case 'heavy snow':
        return 'assets/snowy.json';

      ///////////// cloud with sun
      case 'few clouds':
        return 'assets/few_clouds.json';

      //////////// cloud
      case 'clouds':
      case 'smoke':
      case 'haze':
      case 'mist':
      case 'dust':
      case 'fog':
      case 'overcast clouds':
      case 'broken clouds':
      case 'scattered clouds':
        return 'assets/cloudy.json';
      default:
        return 'assets/cloudy.json';
    }
  }
}



























// // ignore_for_file: unused_field

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController _citySearch = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Weather',
//           style: GoogleFonts.montserrat(
//             textStyle: TextStyle(
//               fontSize: 30,
//               fontFamily: "Montserrat",
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ),
//       body: TextField(
//         controller: _citySearch,
//         decoration: InputDecoration(
//           labelText: 'Search for a city',
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//         ),
//       ),
//     );
//   }
// }
