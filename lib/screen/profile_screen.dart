import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Center(
            child: CircleAvatar(
              backgroundColor: Colors.amber,
              radius: 200,
              child: CircleAvatar(
                radius: 195,
                backgroundImage: AssetImage('images/kiryu.jpg'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
