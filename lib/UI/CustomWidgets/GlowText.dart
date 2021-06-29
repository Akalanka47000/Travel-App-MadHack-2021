import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlowText extends StatelessWidget {
  const GlowText(this.text, this.fontSize);
  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontSize: fontSize,
          color: Colors.white,
          shadows: <Shadow>[
            Shadow(
              offset: Offset(0.0, 0.0),
              blurRadius: 8,
              color: Colors.white.withOpacity(0.8),
            ),
            Shadow(
              offset: Offset(0.0, 0.0),
              blurRadius: 20,
              color: Colors.white.withOpacity(0.8),
            ),
          ],
        ),
      ),
    );
  }
}
