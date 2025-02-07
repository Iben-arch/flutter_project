import 'dart:convert'; // สำหรับแปลง JSON
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modern_profile/screen/post_page.dart';
import '../components/post_card.dart';

class HololiveChatScreen extends StatefulWidget {
  @override
  _HololiveChatScreenState createState() => _HololiveChatScreenState();
}

class _HololiveChatScreenState extends State<HololiveChatScreen> {
  List<Map<String, dynamic>> posts = []; // เก็บโพสต์

  @override
  void initState() {
    super.initState();
    _loadPosts(); // โหลดโพสต์จาก SharedPreferences เมื่อเปิดหน้า
  }

  // ฟังก์ชันบันทึกโพสต์ลง SharedPreferences
  Future<void> _savePosts() async {
    final prefs = await SharedPreferences.getInstance();
    final postsJson = jsonEncode(posts); // แปลง List เป็น JSON String
    await prefs.setString(
        'posts', postsJson); // บันทึก JSON ใน SharedPreferences
  }

  // ฟังก์ชันโหลดโพสต์จาก SharedPreferences
  Future<void> _loadPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final postsJson =
        prefs.getString('posts'); // ดึง JSON String จาก SharedPreferences
    if (postsJson != null) {
      setState(() {
        posts = List<Map<String, dynamic>>.from(jsonDecode(postsJson));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              // Header (แถบด้านบน)
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent, Colors.lightBlueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('About this channel'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.blueAccent,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        DropdownButton(
                          value: 'English',
                          items: [
                            DropdownMenuItem(
                              value: 'English',
                              child: Text('English'),
                            ),
                          ],
                          onChanged: (value) {},
                        ),
                        SizedBox(width: 8),
                        DropdownButton(
                          value: 'Updated',
                          items: [
                            DropdownMenuItem(
                              value: 'Updated',
                              child: Text('Updated'),
                            ),
                            DropdownMenuItem(
                              value: 'Newest',
                              child: Text('Newest'),
                            ),
                          ],
                          onChanged: (value) {},
                        ),
                      ],
                    )
                  ],
                ),
              ),
              // ListView ของโพสต์ทั้งหมด
              Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return PostCard(
                      username: post['username'],
                      imageUrl: post['imageUrl'],
                      text: post['text'],
                      time: post['time'],
                      likes: post['likes'],
                      comments: post['comments'],
                    );
                  },
                ),
              ),
            ],
          ),
          // Floating Action Button (ปุ่มเพิ่มโพสต์)
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () async {
                // เปิดหน้าสร้างโพสต์และรอค่ากลับ
                final newPost = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostThreadPage(),
                  ),
                );

                // ถ้ามีโพสต์ใหม่ ให้เพิ่มเข้า List
                if (newPost != null) {
                  setState(() {
                    posts.add(newPost); // เพิ่มโพสต์ใหม่
                  });
                  _savePosts(); // บันทึกโพสต์ใหม่ลง SharedPreferences
                }
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}
