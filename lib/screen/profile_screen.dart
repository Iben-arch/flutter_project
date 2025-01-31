import 'package:flutter/material.dart';
import 'package:modern_profile/components/profile_img.dart';
import 'package:modern_profile/components/profile_menu.dart';
import 'package:modern_profile/constant/constant.dart';
import 'package:modern_profile/screen/holochat_screen.dart';
import 'package:modern_profile/screen/holodule_screen.dart';
import 'package:modern_profile/screen/home_screen.dart';
import 'editprofile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedItem = 0;
  late PageController _pageController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _navigationBottomNavBar(int index) {
    setState(() {
      _selectedItem = index;
      print(index);
    });
  }

  final List<Widget> _pages = [
    const HomePage(),
    HololiveChatScreen(),
    const HoLoDule(),
    const EditProfileScreen(),
  ];

  final List<String> _title = ['Home', 'Community', 'Holodule', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'assets/images/holoplus_logo.png', // Replace with your logo asset
          height: 40,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.blue),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    color: Colors.white,
                    child: ListView(
                      padding: EdgeInsets.all(8.0),
                      children: [
                        ListTile(
                          title: Text('hololive News',
                              style: TextStyle(color: Colors.black)),
                          trailing: Icon(Icons.verified, color: Colors.blue),
                          onTap: () {
                            // Handle tap
                          },
                        ),
                        ListTile(
                          title: Text('hololive Plus',
                              style: TextStyle(color: Colors.black)),
                          trailing: Icon(Icons.verified, color: Colors.blue),
                          onTap: () {
                            // Handle tap
                          },
                        ),
                        ListTile(
                          title: Text('hololive Chat',
                              style: TextStyle(color: Colors.black)),
                          trailing: Icon(Icons.chat_bubble_outline),
                          onTap: () {
                            // Handle tap
                          },
                        ),
                        // เพิ่มไอเทมใหม่ในเมนูที่นี่
                        ListTile(
                          title: Text('New Menu Item',
                              style: TextStyle(color: Colors.black)),
                          trailing:
                              Icon(Icons.new_releases, color: Colors.orange),
                          onTap: () {
                            // Handle tap
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: _pages[_selectedItem],
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
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Community'),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_collection), label: 'holodule'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
