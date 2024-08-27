import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:lottie/lottie.dart";
import "package:weather_app_tutorial/home_page.dart";

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue[300],
        child: Column(
          children: [
            SizedBox(height: 100),
            Center(
              child: Lottie.asset('assets/shower.json'),
            ),
            const SizedBox(height: 20),
            Text(
              'Welcome to Weather App',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            // const SizedBox(height: 10),
            Text(
              'Discover the weather in your\ncity and plan your day\ncorrectly',
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
                // Navigator.pushNamed(context, '/enterLocation');
              },
              child: Text(
                'Get Started',
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ), //// or montserrat
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 245, 207, 41),
                foregroundColor: Color.fromRGBO(254, 253, 252, 20), //// text color in button
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
