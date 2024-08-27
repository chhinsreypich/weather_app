// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_tutorial/widgets/textInColumn.dart';

class Display extends StatelessWidget {
  const Display({
    super.key,
    this.city,
    this.temp,
    this.feelLike,
    this.weather,
    this.humidity,
    this.pressure,
    this.windSpeed,
    this.windDirection,
    required this.iconPic,
    this.onTapp,
  });
  final city;
  final feelLike;
  final weather;
  final pressure;
  final humidity;
  final windSpeed;
  final windDirection;
  final temp;
  final iconPic;
  final onTapp;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[300],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
            child: Column(
              children: [
                ////// city
                Text(
                  city,
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 34,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                /////// date
                Text(
                  DateFormat.MMMMEEEEd().format(DateTime.now()),
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                /////// icon pic
                Container(
                  width: 300,
                  child: Expanded(
                    child: iconPic,
                  ),
                ),
      
                /////// temp
                Text(
                  temp,
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                //////// weather
                Text(
                  weather,
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Feel Like: ${feelLike}",
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ////// row below
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        /////// humidity
                        TextInColumn(
                          theString: 'Humidity',
                          thePara: humidity,
                        ),
                        /////// pressure
                        TextInColumn(
                          theString: 'Pressure',
                          thePara: pressure,
                        ),
                        /////// wind speed
                        TextInColumn(
                          theString: 'Wind Speed',
                          thePara: windSpeed,
                        ),
                        ////// wind direction
                        TextInColumn(
                          theString: 'Wind Direction',
                          thePara: windDirection,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
