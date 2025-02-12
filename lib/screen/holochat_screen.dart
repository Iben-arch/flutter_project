import 'dart:convert'; // สำหรับแปลง JSON
import 'package:flutter/material.dart';
import 'package:modern_profile/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modern_profile/screen/post_page.dart';
import '../components/post_card.dart';

class HololiveChatScreen extends StatefulWidget {
  @override
  _HololiveChatScreenState createState() => _HololiveChatScreenState();
}

class _HololiveChatScreenState extends State<HololiveChatScreen> {
  List<Map<String, dynamic>> posts = []; // เก็บโพสต์
  bool isOshiOn = false; // สถานะของปุ่ม Oshi
  bool isAboutExpanded = false; // สถานะการแสดงรายละเอียดของ About
  String selectedUpdate = 'Updated'; // ค่าที่เลือกของปุ่ม Updated
  // กำหนดข้อความเริ่มต้นที่จะแสดงใน TextField
  // ข้อความที่เราต้องการแสดงใน "About this channel"
  String aboutText = '''Post anything about hololive!\n
      Feel free to talk about streams, live events, merch \n
      info, and much more\n\n
      Consider the following and create a positive\n
      community for everyone !\n
      share exciting news and favorite moments\n
      Support live concerts and events together\n
      Report or block harmful posts form(...) on posts!''';

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

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              // Header (แถบด้านบน)
              Container(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isAboutExpanded = !isAboutExpanded;
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'About this channel',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    // กล่องข้อความสำหรับ About ที่มีข้อความเริ่มต้น
                    if (isAboutExpanded)
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue, // พื้นหลังเป็นสีน้ำเงิน
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.blue),
                          ),
                          child: Text(
                            aboutText, // ข้อความที่ต้องการแสดง
                            style: TextStyle(
                              fontSize: 12, // ขนาดตัวอักษรเล็กลง
                              color: Colors.white, // สีตัวอักษรเป็นขาว
                            ),
                          ),
                        ),
                      ),

                    SizedBox(height: 8),

                    // ปุ่มตัวเลือก
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              isOshiOn = !isOshiOn;
                            });
                          },
                          icon: Icon(
                            Icons.filter_alt_outlined,
                            color: isOshiOn ? Colors.white : Colors.blue,
                          ),
                          label: Text(
                            isOshiOn ? 'Oshi On' : 'Oshi Off',
                            style: TextStyle(
                                color: isOshiOn ? Colors.white : Colors.blue),
                          ),
                          style: ElevatedButton.styleFrom(
                            foregroundColor:
                                isOshiOn ? Colors.white : Colors.blue,
                            backgroundColor:
                                isOshiOn ? Colors.blue : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: Colors.blue),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 6),
                          ),
                        ),
                        SizedBox(width: 6),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.language,
                              color: Colors.blue, size: 18),
                          label: Text('English',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 14)),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.blue,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: Colors.blue),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 6),
                          ),
                        ),
                        SizedBox(width: 6),
                        PopupMenuButton<String>(
                          onSelected: (value) {
                            setState(() {
                              selectedUpdate = value;
                            });
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                                value: 'Updated', child: Text('Updated')),
                            PopupMenuItem(
                                value: 'Newest', child: Text('Newest')),
                          ],
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 6),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.table_rows_sharp,
                                    color: Colors.blue, size: 18),
                                SizedBox(width: 4),
                                Text(selectedUpdate,
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 14)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
                final newPost = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PostThreadPage()),
                );
                if (newPost != null) {
                  setState(() {
                    posts.add(newPost);
                  });
                  _savePosts();
                }
              },
              child: Icon(Icons.filter_none_rounded, color: Colors.white),
              backgroundColor: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}
