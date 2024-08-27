// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCard extends StatelessWidget {
  const MyCard({
    super.key,
    this.city,
    this.feelLike,
    this.weather,
    this.pressure,
    this.windSpeed,
    this.windDirection,
    this.temp,
    required this.iconPic,
    this.onTapp,
  });
  final city;
  final feelLike;
  final weather;
  final pressure;
  final windSpeed;
  final windDirection;
  final temp;
  final iconPic;
  final onTapp;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[400],
          borderRadius: BorderRadius.circular(20.0),
        ),
        width: 420,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: [
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // City
                  Text(
                    city,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  // weather
                  Text(
                    weather,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),

                  /// temp
                  Text(
                    temp,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        fontSize: 36,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 50),
              Expanded(
                // child: Image.network(
                //   iconPic,
                //   // height: 130,
                //   fit: BoxFit.fill,
                // ),
                child: iconPic,
              ),
              SizedBox(width: 30),
            ],
          ),
        ),
      ),
    );
  }
}
