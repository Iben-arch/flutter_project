import 'package:flutter/material.dart';
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
  String? _selectedCategory;

  void _navigationBottomNavBar(int index) {
    setState(() {
      _selectedItem = index;
      _selectedCategory = null; // รีเซ็ตหมวดหมู่เมื่อเปลี่ยนแท็บ
    });
  }

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
          'assets/images/holoplus_logo.png',
          height: 40,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.blue),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    color: Colors.white,
                    child: ListView(
                      padding: const EdgeInsets.all(8.0),
                      children: [
                        ListTile(
                          title: const Text('hololive News',
                              style: TextStyle(color: Colors.black)),
                          trailing:
                              const Icon(Icons.verified, color: Colors.blue),
                          onTap: () {
                            setState(() {
                              _selectedItem = 1; // ไปที่หน้า Community
                              _selectedCategory =
                                  'Holo News'; // กรองเฉพาะ Holo News
                            });
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: const Text('hololive Chat',
                              style: TextStyle(color: Colors.black)),
                          trailing: const Icon(Icons.chat_bubble_outline),
                          onTap: () {
                            setState(() {
                              _selectedItem = 1; // ไปที่หน้า Community
                              _selectedCategory = null; // แสดงทุกโพสต์
                            });
                            Navigator.pop(context);
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
      body: _selectedItem == 1
          ? HololiveChatScreen(
              category: _selectedCategory,
            ) // ✅ ส่งค่า category ไปยัง HololiveChatScreen
          : _selectedItem == 0
              ? const HomePage()
              : _selectedItem == 2
                  ? const HoLoDule()
                  : const EditProfileScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedItem,
        onTap: _navigationBottomNavBar,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Community'),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_collection), label: 'Holodule'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
