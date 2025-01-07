import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const bgPrimaryColor = Color.fromARGB(255, 59, 68, 165);
const bgSecondaryColor = Color.fromARGB(255, 189, 193, 248);

const textPrimaryColor = Color.fromARGB(255, 137, 128, 217);
const textSecondaryColor = Color.fromARGB(255, 74, 122, 193);

const iconPrimaryColor = Color.fromARGB(255, 172, 53, 235);
const iconSecondaryColor = Color.fromARGB(255, 254, 134, 242);

final textTitle = GoogleFonts.poppins(
  fontSize: 20,
  fontWeight: FontWeight.w600,
  color: textSecondaryColor,
);

final textSubTitle = GoogleFonts.poppins(
  fontSize: 15,
  fontWeight: FontWeight.w600,
  color: textPrimaryColor,
);

final textBtn = GoogleFonts.poppins(
  fontSize: 18,
  color: const Color.fromARGB(255, 246, 143, 210),
  fontWeight: FontWeight.w500,
);
