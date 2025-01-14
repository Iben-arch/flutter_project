import 'package:flutter/material.dart';
import 'package:modern_profile/components/profile_img.dart';
import 'package:modern_profile/components/profile_menu.dart';
import 'package:modern_profile/constant/constant.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedItem = 0;

  void _navigationBottomNavBar(int index) {
    setState(() {
      _selectedItem = index;
      print(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: iconPrimaryColor,
        ),
        title: Center(
            child: Text(
          'Edit Profile',
          style: textTitle,
        )),
        actions: const [
          Icon(
            Icons.exit_to_app,
            size: 25,
            color: iconPrimaryColor,
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
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
              height: 200,
            ),
            const ProfileMenu(
              title: 'Logout',
              icons: Icons.logout,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedItem,
        onTap: _navigationBottomNavBar,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorite'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
        ],
      ),
    );
  }
}
