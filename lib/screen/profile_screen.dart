import 'package:flutter/material.dart';
import 'package:modern_profile/constant/constant.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.amber,
                  radius: 60,
                  child: CircleAvatar(
                    radius: 55,
                    backgroundImage: AssetImage('images/kiryu.jpg'),
                  ),
                ),
                CircleAvatar(
                  backgroundColor: bgPrimaryColor,
                  radius: 22,
                  child: CircleAvatar(
                    backgroundColor: Colors.amber,
                    child: Icon(
                      Icons.edit,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
