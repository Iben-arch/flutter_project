import 'package:flutter/material.dart';
import 'screen/profile_screen.dart';

void main(List<String> args) {
  runApp(const HoloPlusApp());
}

class HoloPlusApp extends StatelessWidget {
  const HoloPlusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Holoplus+',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ProfileScreen(),
    );
  }
}
