import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modern_profile/screen/edit_oshi_page.dart';
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
  List<String> _selectedOshi = [];

  final List<String> _iconPaths = [
    'assets/profile/profile1.png',
    'assets/profile/profile2.png',
    'assets/profile/profile3.png',
    'assets/profile/profile4.png',
    'assets/profile/profile5.png',
    'assets/profile/profile6.png',
    'assets/profile/profile7.png',
    'assets/profile/profile8.png',
    'assets/profile/profile9.png',
    // Add more icon paths here
  ];

  final List<String> _oshiPaths = [
    'assets/icons/icon1.png',
    'assets/icons/icon2.png',
    'assets/icons/icon3.png',
    'assets/icons/icon4.png',
    'assets/icons/icon5.png',
  ];

  final List<String> _oshiNames = [
    'Tokino Sora',
    'Robocosan',
    'AZKi',
    'Sakura Miko',
    'Hoshimachi Suisei'
  ];
  @override
  void initState() {
    super.initState();
    _loadAvatarImage();
    _loadSelectedOshi();
  }

  Future<void> _loadAvatarImage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedImagePath = prefs.getString('avatar_image');
    setState(() {
      _avatarImage = savedImagePath != null
          ? AssetImage(savedImagePath)
          : const AssetImage('assets/profile/profile8.png');
    });
  }

  Future<void> _saveAvatarImage(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('avatar_image', path);
  }

  Future<void> _loadSelectedOshi() async {
    final prefs = await SharedPreferences.getInstance();
    final savedOshi = prefs.getStringList('selected_oshi') ?? [];
    setState(() {
      _selectedOshi = savedOshi;
    });
  }

  Future<void> _saveSelectedOshi(List<String> selectedOshi) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('selected_oshi', selectedOshi);
  }

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          padding: const EdgeInsets.all(10),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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

  void _navigateToEditOshi() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditOshiPage(
          selectedOshi: _selectedOshi,
          oshiNames: _oshiNames,
          oshiPaths: _oshiPaths, // ส่งข้อมูลรูปภาพ
        ),
      ),
    );
    if (result != null && result is List<String>) {
      setState(() {
        _selectedOshi = result;
      });
      _saveSelectedOshi(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Container(
            margin: const EdgeInsets.only(left: 250),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.blue,
              ),
              label: const Text(
                'Settings',
                style: TextStyle(color: Colors.blue),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
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
                              icon: const Icon(null),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: 17,
                              backgroundColor: Colors.blue,
                              child: IconButton(
                                icon: const Icon(
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
                      const Center(
                        child: Row(
                          children: [
                            Image(
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
                            onPressed: _navigateToEditOshi,
                            child: const Text('Edit',
                                style: TextStyle(color: Colors.blue)),
                          )
                        ],
                      ),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final maxIconsPerRow =
                              (constraints.maxWidth / 60).floor();
                          final rows = List.generate(
                            (_selectedOshi.length / maxIconsPerRow).ceil(),
                            (rowIndex) => _selectedOshi
                                .skip(rowIndex * maxIconsPerRow)
                                .take(maxIconsPerRow),
                          );

                          return Column(
                            children: rows.map((row) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: row.map((name) {
                                  final index = _oshiNames.indexOf(name);
                                  return Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: CircleAvatar(
                                      radius: 25 / rows.length,
                                      backgroundImage:
                                          AssetImage(_oshiPaths[index]),
                                    ),
                                  );
                                }).toList(),
                              );
                            }).toList(),
                          );
                        },
                      ),
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
