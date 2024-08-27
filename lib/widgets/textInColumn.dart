// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextInColumn extends StatelessWidget {
  const TextInColumn({
    super.key,
    this.theString,
    this.thePara,
  });

  final theString;
  final thePara;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: Column(
        children: [
          Text(
            theString,
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            thePara,
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
