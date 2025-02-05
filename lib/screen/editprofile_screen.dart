import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modern_profile/screen/setting_page.dart';
import '../components/oshi_avatar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    super.key,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  ImageProvider<Object>? _avatarImage;

  final List<String> _iconPaths = [
    'assets/profile/bear.png',
    'assets/profile/robot.png',
    'assets/profile/Tool.png',
    'assets/profile/sakura.png',
    'assets/profile/suisei.png',
    // Add more icon paths here
  ];
  @override
  void initState() {
    super.initState();
    _loadAvatarImage();
  }

  Future<void> _loadAvatarImage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedImagePath = prefs.getString('avatar_image');
    setState(() {
      _avatarImage = savedImagePath != null
          ? AssetImage(savedImagePath)
          : AssetImage('assets/profile/suisei.png');
    });
  }

  Future<void> _saveAvatarImage(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('avatar_image', path);
  }

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          padding: EdgeInsets.all(10),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: _iconPaths.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _avatarImage = AssetImage(_iconPaths[index]);
                  });
                  _saveAvatarImage(_iconPaths[index]);
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                  backgroundImage: AssetImage(_iconPaths[index]),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.only(left: 250),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
              icon: Icon(
                Icons.settings,
                color: Colors.blue,
              ),
              label: Text(
                'Settings',
                style: TextStyle(color: Colors.blue),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                elevation: 2,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                            backgroundImage: _avatarImage,
                            child: IconButton(
                              onPressed: _pickImage,
                              tooltip: 'Change Image',
                              icon: Icon(null),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: 17,
                              backgroundColor: Colors.blue,
                              child: IconButton(
                                icon: Icon(
                                    Icons.photo_size_select_actual_outlined,
                                    color: Colors.white),
                                iconSize: 20,
                                onPressed: _pickImage,
                                tooltip: 'Change Image',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Nora',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Center(
                        child: const Row(
                          children: [
                            const Image(
                              image:
                                  AssetImage('assets/icons/icon_holoplus.png'),
                              width: 20,
                              height: 20,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'holoplus points',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              'LV 1   0+',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                          height: 20,
                          thickness: 1,
                          color: Colors.grey.shade300),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'My Oshi',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Edit',
                                style: TextStyle(color: Colors.blue)),
                          )
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: List.generate(
                      //     5,
                      //     (index) => CircleAvatar(
                      //       radius: 25,
                      //       backgroundColor: Colors.grey.shade300,
                      //       child: Icon(Icons.person, color: Colors.blue),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
