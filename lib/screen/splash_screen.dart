import 'dart:async';

import 'package:flutter/material.dart';
import 'package:modern_profile/screen/edit_oshi_page.dart';
import 'package:modern_profile/screen/home_screen.dart';
import 'package:modern_profile/screen/profile_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Timer ให้หน้า SplashScreen อยู่แค่ 3 วินาที
    Timer(Duration(seconds: 3), () {
      // หลังจาก 3 วินาที ไปหน้า Home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          opacity: 1.0,
          duration: Duration(seconds: 2),
          child: Image.asset('assets/icons/icon_holoplus.png'),
        ),
      ),
    );
  }
}
