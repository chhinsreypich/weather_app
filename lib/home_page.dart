// ignore_for_file: sort_child_properties_last, deprecated_member_use, prefer_typing_uninitialized_variables, dead_code, unused_field, prefer_final_fields, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:weather_app_tutorial/pages/searchScreen.dart';
import 'package:weather_app_tutorial/widgets/display.dart';
import 'package:weather_app_tutorial/widgets/my_card.dart';
import 'dart:convert';
// import 'google_fonts';
import 'consts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _weatherData; ////// for one city
  List _weatherDataList = [];
  bool _loading = true;
  final TextEditingController _cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // fetchOneCityWeather(widget.city);
    fetchWeather([
      'Phnom Penh',
      // 'Sihanoukville',
      'Seoul',
      'Bangkok',
      'London',
      'Paris',
      'Tokyo',
      'New York',
      'Los Angeles',
      'Sydney',
      'Melbourne',
      'Singapore',
      'Kuala Lumpur',
      'Hong Kong',
      'Taipei',
      'Beijing',
      'Hanoi',
    ]);
  }

  Future<void> fetchWeather(List cities) async {
    setState(() {
      _loading = true;
    });
    for (var city in cities) {
      final response =
          await http.get(Uri.parse('$apiUrl?q=$city&appid=$apiKey'));
      if (response.statusCode == 200) {
        setState(() {
          _weatherDataList.add(json.decode(response.body));
          _loading = false;
        });
      } else {
        throw Exception('Failed to load weather data');
      }
    }
    setState(() {
      _loading = false;
    });
  }

  Future<void> fetchOneCityWeather(String city) async {
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
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'Weather',
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        fontSize: 30,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      Navigator.pushNamed(context, '/searchScreen');
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : WeatherDisplay(weatherDataList: _weatherDataList),
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherDisplay extends StatelessWidget {
  final List weatherDataList;

  const WeatherDisplay({super.key, required this.weatherDataList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: weatherDataList.length,
      itemBuilder: (context, index) {
        String iconCode = weatherDataList[index]['weather'][0]['icon'];
        String lottieAnimation = getWeatherAnimation( weatherDataList[index]['weather'][0]['description']);

        return GestureDetector(
          child: MyCard(
            city: '${weatherDataList[index]['name']}',
            weather: '${weatherDataList[index]['weather'][0]['description']}',
            temp:
                "${(weatherDataList[index]['main']['temp'] - 273.15).toStringAsFixed(2)}°C",
            iconPic: Lottie.asset(lottieAnimation),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(cityOnTap: '${weatherDataList[index]['name']}')));
          },
        );
      },
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

//////////////////////////////////////  sihavnouk

// class WeatherDisplay extends StatelessWidget {
//   final Map weatherData;

//   const WeatherDisplay({super.key, required this.weatherData});

//   @override
//   Widget build(BuildContext context) {
//     String iconCode = weatherData['weather'][0]['icon'];
//     String iconUrl = 'http://openweathermap.org/img/wn/$iconCode@2x.png';

//     String lottieAnimation =
//         getWeatherAnimation(weatherData['weather'][0]['description']);

//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             GestureDetector(
//               child: MyCard(
//                 city: '${weatherData['name']}',
//                 // city: 'My Location',
//                 weather: '${weatherData['weather'][0]['description']}',
//                 temp:
//                     "${(weatherData['main']['temp'] - 273.15).toStringAsFixed(2)}°C",
//                 // iconPic: iconUrl,
//                 iconPic: Lottie.asset(lottieAnimation),
//               ),
//               onTap: () {
//                 Navigator.pushNamed(context, '/');
//                 /////////// add class like card to enter new page when we tap on it
//               },
//             ),

//             // Phnom Penh
//             GestureDetector(
//               child: MyCard(
//                 city: 'Phnom Penh',
//                 weather: '${weatherData['weather'][0]['description']}',
//                 temp:
//                     "${(weatherData['main']['temp'] - 273.15).toStringAsFixed(2)}°C",
//                 // iconPic: iconUrl,
//                 iconPic: Lottie.asset(lottieAnimation),
//               ),
//               onTap: () {
//                 Navigator.pushNamed(context, '/');
//                 /////////// add class like card to enter new page when we tap on it
//               },
//             ),

//             // Seoul
//             GestureDetector(
//               child: MyCard(
//                 city: 'Seoul',
//                 weather: '${weatherData['weather'][0]['description']}',
//                 temp:
//                     "${(weatherData['main']['temp'] - 273.15).toStringAsFixed(2)}°C",
//                 // iconPic: iconUrl,
//                 iconPic: Lottie.asset(lottieAnimation),
//               ),
//               onTap: () {
//                 Navigator.pushNamed(context, '/');
//                 /////////// add class like card to enter new page when we tap on it
//               },
//             ),
//             ////********************************************************************** */

//             Text(
//               '${weatherData['name']}', //////////////////// City
//               style: const TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Container(
//               child: Image.network(iconUrl),
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Temperature: ${(weatherData['main']['temp'] - 273.15).toStringAsFixed(2)}°C',
//               style: const TextStyle(fontSize: 24),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Feels Like: ${(weatherData['main']['feels_like'] - 273.15).toStringAsFixed(2)}°C',
//               style: const TextStyle(fontSize: 20),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Weather: ${weatherData['weather'][0]['description']}',
//               style: const TextStyle(fontSize: 24),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Humidity: ${weatherData['main']['humidity']}%',
//               style: const TextStyle(fontSize: 20),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Pressure: ${weatherData['main']['pressure']} hPa',
//               style: const TextStyle(fontSize: 20),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Wind Speed: ${weatherData['wind']['speed']} m/s',
//               style: const TextStyle(fontSize: 20),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Wind Direction: ${weatherData['wind']['deg']}°',
//               style: const TextStyle(fontSize: 20),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   String getWeatherAnimation(String mainCondition) {
//     if (mainCondition == null) return 'assets/sunny.json';
//     switch (mainCondition.toLowerCase()) {
//       ///////////// rain
//       case 'rain':
//       case 'drizzle':
//       case 'light rain':
//       case 'shower rain':
//       case 'moderate rain':
//       case 'heavy intensity rain':
//       case 'very heavy rain':
//         return 'assets/rain.json';

//       ///////////// clear sky or sunny
//       case 'clear sky':
//       case 'sunny':
//         return 'assets/sunny.json';

//       ////////////// thunder
//       case 'thunder':
//       case "thunderstorm":
//       case "light thunderstorm":
//       case "heavy thunderstorm":
//       case "ragged thunderstorm":
//         return 'assets/thunder.json';

//       ///////////// snowy
//       case 'snowy':
//       case 'light snow':
//       case 'heavy snow':
//         return 'assets/snowy.json';

//       ///////////// cloud with sun
//       case 'few clouds':
//         return 'assets/few_clouds.json';

//       //////////// cloud
//       case 'clouds':
//       case 'smoke':
//       case 'haze':
//       case 'mist':
//       case 'dust':
//       case 'fog':
//       case 'overcast clouds':
//       case 'broken clouds':
//       case 'scattered clouds':
//         return 'assets/cloudy.json';
//       default:
//         return 'assets/cloudy.json';
//     }
//   }
// }

/****************
 * 
 * 
 * 
 * 
 * 
 * 
 * 
 * 
 */
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'consts.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   var _weatherData;
//   bool _loading = true;
//   final TextEditingController _cityController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     fetchWeather('Sihanoukville');
//   }

//   Future<void> fetchWeather(String city) async {
//     setState(() {
//       _loading = true;
//     });
//     final response = await http.get(Uri.parse('$apiUrl?q=$city&appid=$apiKey'));
//     if (response.statusCode == 200) {
//       setState(() {
//         _weatherData = json.decode(response.body);
//         _loading = false;
//       });
//     } else {
//       throw Exception('Failed to load weather data');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Weather App'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _cityController,
//                     decoration: const InputDecoration(
//                       labelText: 'Enter city name',
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.search),
//                   onPressed: () {
//                     fetchWeather(_cityController.text);
//                   },
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: _loading
//                 ? const Center(child: CircularProgressIndicator())
//                 : WeatherDisplay(weatherData: _weatherData),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class WeatherDisplay extends StatelessWidget {
//   final Map weatherData;

//   const WeatherDisplay({super.key, required this.weatherData});

//   @override
//   Widget build(BuildContext context) {
//     String iconCode = weatherData['weather'][0]['icon'];
//     String iconUrl = 'http://openweathermap.org/img/wn/$iconCode@2x.png';

//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               'City: ${weatherData['name']}',
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),
//             Image.network(iconUrl),
//             const SizedBox(height: 16),
//             Text(
//               'Temperature: ${(weatherData['main']['temp'] - 273.15).toStringAsFixed(2)}°C',
//               style: const TextStyle(fontSize: 24),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Feels Like: ${(weatherData['main']['feels_like'] - 273.15).toStringAsFixed(2)}°C',
//               style: const TextStyle(fontSize: 20),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Weather: ${weatherData['weather'][0]['description']}',
//               style: const TextStyle(fontSize: 24),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Humidity: ${weatherData['main']['humidity']}%',
//               style: const TextStyle(fontSize: 20),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Pressure: ${weatherData['main']['pressure']} hPa',
//               style: const TextStyle(fontSize: 20),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Wind Speed: ${weatherData['wind']['speed']} m/s',
//               style: const TextStyle(fontSize: 20),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Wind Direction: ${weatherData['wind']['deg']}°',
//               style: const TextStyle(fontSize: 20),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
