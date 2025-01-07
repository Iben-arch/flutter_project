import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            backgroundColor: Color.fromARGB(255, 68, 156, 250),
            radius: 60,
            child: CircleAvatar(
              radius: 55,
              backgroundImage: AssetImage('images/kiryu.jpg'),
            ),
          ),
          CircleAvatar(
            backgroundColor: Color.fromARGB(255, 37, 77, 120),
            radius: 22,
            child: CircleAvatar(
              backgroundColor: Color.fromARGB(255, 194, 156, 251),
              child: Icon(
                Icons.edit,
                size: 20,
                color: Color.fromARGB(255, 37, 77, 120),
              ),
            ),
          )
        ],
      ),
    );
  }
}
