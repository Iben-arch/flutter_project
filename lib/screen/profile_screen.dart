import 'package:flutter/material.dart';
import 'package:modern_profile/components/profile_img.dart';
import 'package:modern_profile/components/profile_menu.dart';
import 'package:modern_profile/constant/constant.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          const ProfileImage(),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Nonlawat Weerasuthiranawin',
            style: textTitle,
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            'Email : bourbok49@gmail.com',
            style: textSubTitle,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: 150,
            height: 40,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 179, 223, 255),
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Center(
                child: Text(
              'Edit Profile',
              style: textBtn,
            )),
          ),
          const SizedBox(
            height: 20,
          ),
          const ProfileMenu(
            title: 'Setting',
            icons: Icons.settings,
          ),
          const SizedBox(
            height: 20,
          ),
          const ProfileMenu(
            title: 'Billing Detail',
            icons: Icons.wallet,
          ),
          const SizedBox(
            height: 20,
          ),
          const ProfileMenu(
            title: 'User Management',
            icons: Icons.person,
          ),
          const SizedBox(
            height: 20,
          ),
          const ProfileMenu(
            title: 'Add Friends',
            icons: Icons.social_distance,
          ),
          const SizedBox(
            height: 40,
          ),
          const ProfileMenu(
            title: 'Logout',
            icons: Icons.logout,
          ),
        ],
      ),
    );
  }
}
