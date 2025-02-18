import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:modern_profile/screen/post_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../components/post_card.dart';

class HololiveChatScreen extends StatefulWidget {
  final String? category;

  const HololiveChatScreen({super.key, this.category});

  @override
  _HololiveChatScreenState createState() => _HololiveChatScreenState();
}

class _HololiveChatScreenState extends State<HololiveChatScreen> {
  List<Map<String, dynamic>> posts = [];
  List<Map<String, dynamic>> filteredPosts = [];
  bool isOshiOn = false;
  bool isAboutExpanded = false;
  String selectedUpdate = 'Updated';

  final uuid = Uuid();

  // 🔹 โพสต์ที่กำหนดไว้ล่วงหน้าสำหรับ Holo News (ไม่บันทึกลง SharedPreferences)
  final List<Map<String, dynamic>> defaultPosts = [
    {
      "id": "news-001",
      "username": "Hololive Official",
      "imageUrl": "assets/images/holonews1.jpg",
      "text": "🎧SONG RELEASE!! Aki Rosenthal’s「異薔薇」🍎",
      "time": "2 hours ago",
      "likes": 1500,
      "comments": 320,
      "category": "Holo News"
    },
    {
      "id": "news-002",
      "username": "HoloLive Official",
      "imageUrl": "assets/images/holonews2.jpg",
      "text":
          "🍎Don't let the celebration stop!🎉AkiRose birthday Merch available!!",
      "time": "1 day ago",
      "likes": 2300,
      "comments": 450,
      "category": "Holo News"
    },
    {
      "id": "news-003",
      "username": "HoloLive Official",
      "imageUrl": "assets/images/holonews3.jpg",
      "text":
          "✈️Relive hololive STAGE World Tour ’24 Soar! with the Post-Event Report✨",
      "time": "1 day ago",
      "likes": 2300,
      "comments": 450,
      "category": "Holo News"
    }
  ];

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _savePosts() async {
    final prefs = await SharedPreferences.getInstance();
    final postsJson = jsonEncode(posts);
    await prefs.setString('posts', postsJson);
  }

  Future<void> _loadPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final postsJson = prefs.getString('posts');

    if (postsJson != null && postsJson.isNotEmpty) {
      List<Map<String, dynamic>> loadedPosts =
          List<Map<String, dynamic>>.from(jsonDecode(postsJson));

      setState(() {
        posts = loadedPosts;
      });
    } else {
      setState(() {
        posts = [];
      });
    }

    _filterPosts();
  }

  void _filterPosts() {
    setState(() {
      if (widget.category == "Holo News") {
        filteredPosts = List.from(defaultPosts); // ✅ แสดงเฉพาะโพสต์ข่าว
      } else {
        filteredPosts = List.from(posts); // ✅ แสดงเฉพาะโพสต์ของผู้ใช้
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
                if (isAboutExpanded)
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.blue),
                      ),
                      child: Text(
                        'Post anything about hololive!\n\n'
                        'Feel free to talk about streams, live events, merch info, and more!\n\n'
                        'Consider the following and create a positive community for everyone!',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
                SizedBox(height: 8),
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
                        foregroundColor: isOshiOn ? Colors.white : Colors.blue,
                        backgroundColor: isOshiOn ? Colors.blue : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.blue),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
                        PopupMenuItem(value: 'Updated', child: Text('Updated')),
                        PopupMenuItem(value: 'Newest', child: Text('Newest')),
                      ],
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
          Expanded(
            child: ListView.builder(
              itemCount: filteredPosts.length,
              itemBuilder: (context, index) {
                final post = filteredPosts[index];
                return PostCard(
                  id: post['id'],
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
      floatingActionButton: widget.category == "Holo News"
          ? null // ✅ ซ่อนปุ่มเพิ่มโพสต์ถ้าอยู่ใน Holo News
          : FloatingActionButton(
              onPressed: () async {
                final newPost = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PostThreadPage()),
                );
                if (newPost != null) {
                  setState(() {
                    newPost['id'] = uuid.v4();
                    posts.add(newPost);
                    _filterPosts();
                  });
                  _savePosts();
                }
              },
              child: Icon(Icons.filter_none_rounded, color: Colors.white),
              backgroundColor: Colors.blueAccent,
            ),
    );
  }
}
