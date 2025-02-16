import 'dart:async';

import 'package:flutter/material.dart';
import '../components/detail_card.dart';
import '../components/home_img.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'post_detail_page.dart';
import 'post_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //////////////////////////////////////////////////////////////////////////////
  ImageProvider<Object>? _avatarImage;
  bool isOshiOn = false; // สถานะของปุ่ม Oshi

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
    super.initState();
    _pageController = PageController(initialPage: currentBannerIndex);
    _startBannerTimer();
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

  ////////////////////////////////////////////////////////////////////////////
  bool isJapanese = false;
  int currentBannerIndex = 0;
  Timer? _bannerTimer;
  late PageController _pageController;

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startBannerTimer() {
    _bannerTimer = Timer.periodic(const Duration(seconds: 8), (timer) {
      setState(() {
        currentBannerIndex = (currentBannerIndex + 1) % bannerData.length;
        _pageController.animateToPage(
          currentBannerIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    });
  }

  void toggleLanguage(String? language) {
    setState(() {
      isJapanese = language == '日本語';
    });
  }

  final List<Map<String, String>> bannerData = [
    {
      'image': 'assets/images/featured_banner1.jpg',
      'url':
          'https://hololivesuperexpo2025.hololivepro.com/en?utm_source=holoplus&utm_medium=social&utm_campaign=hp_topbanner_global/banner1'
    },
    {
      'image': 'assets/images/featured_banner2.jpg',
      'url':
          'https://grimoire.hololivepro.com/?utm_source=holoplus&utm_medium=social&utm_campaign=hp_topbanner_global/banner2'
    },
    {
      'image': 'assets/images/featured_banner3.jpg',
      'url':
          'https://supernova.hololivepro.com/?utm_source=holoplus&utm_medium=social&utm_campaign=hp_topbanner_global/banner3'
    },
    {
      'image': 'assets/images/featured_banner4.jpg',
      'url':
          'https://fbkingdom.hololivepro.com/?utm_source=holoplus&utm_medium=social&utm_campaign=hp_topbanner_global/banner4'
    },
    {
      'image': 'assets/images/featured_banner5.jpg',
      'url':
          'https://shop.hololivepro.com/en/products/hololive_valentinevoice2025?utm_source=holoplus&utm_medium=social&utm_campaign=hp_topbanner_global/banner5'
    },
  ];

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  List<Map<String, dynamic>> posts = [
    {
      'username': 'Hololive Official',
      'imageUrl': 'assets/images/featured0.jpg',
      'text': 'Sakamata Chloe\'s final stream',
      'time': '2 hours ago',
      'likes': 120,
      'comments': [],
    },
    {
      'username': 'Hololive Official',
      'imageUrl': 'assets/images/featured00.jpg',
      'text': "Today is Mococo Abyssgaurd's Birthday",
      'time': '5 hours ago',
      'likes': 200,
      'comments': [],
    },
    {
      'username': 'Hololive Official',
      'imageUrl': 'assets/images/featured1.jpg',
      'text': 'Sakamata Chloe\'s final stream',
      'time': '2 hours ago',
      'likes': 200,
      'comments': [],
    },
  ];
  List<Map<String, dynamic>> posts1 = [
    {
      'username': 'Hololive Official',
      'imageUrl': 'assets/images/featured3.jpg',
      'text': 'Additionnal general ticket sales starts SOON hololive 6th fes.',
      'time': '1 hours ago',
      'likes': 500,
      'comments': [],
    },
    {
      'username': 'Hololive Official',
      'imageUrl': 'assets/images/featured4.jpg',
      'text': "Get ready for moona Hoshinova's 3D Birthday LIVE!!",
      'time': '3 hours ago',
      'likes': 50,
      'comments': [],
    },
    {
      'username': 'Hololive Official',
      'imageUrl': 'assets/images/featured5.jpg',
      'text': 'Check out the digital message boards for FBKINGDOM "ANTHEM"',
      'time': '1 week ago',
      'likes': 140,
      'comments': [],
    },
  ];

  List<Map<String, dynamic>> posts2 = [
    {
      'username': 'Hololive Official',
      'imageUrl': 'assets/images/featured6.jpg',
      'text': 'Share your post-live thoughts for "SuperNova"',
      'time': '1 hours ago',
      'likes': 500,
      'comments': [],
    },
    {
      'username': 'Hololive Official',
      'imageUrl': 'assets/images/featured7.jpg',
      'text':
          "Post-live chat How was Hoshimachi Suisei's 'Spectra of Nova' at Ookini Arena Maishima?",
      'time': '3 hours ago',
      'likes': 50,
      'comments': [],
    },
  ];

  List<Map<String, dynamic>> posts3 = [
    {
      'username': 'Hololive Official',
      'imageUrl': 'assets/images/featured31.jpg',
      'text': 'Day 17 since my oshi Chloe graduated',
      'time': '1 hours ago',
      'likes': 500,
      'comments': [],
    },
    {
      'username': 'Hololive Official',
      'imageUrl': 'assets/images/featured32.jpg',
      'text': "What are you doing?",
      'time': '3 hours ago',
      'likes': 50,
      'comments': [],
    },
    {
      'username': 'Hololive Official',
      'imageUrl': 'assets/images/featured33.jpg',
      'text': "Can't have to many Irys",
      'time': '1 week ago',
      'likes': 140,
      'comments': [],
    },
  ];

  List<Map<String, dynamic>> posts4 = [
    {
      'username': 'Hololive Official',
      'imageUrl': 'assets/images/featured41.jpg',
      'text': 'New TCG collections available in the USA',
      'time': '1 hours ago',
      'likes': 500,
      'comments': [],
    },
    {
      'username': 'Hololive Official',
      'imageUrl': 'assets/images/featured42.jpg',
      'text': '"Comfy Snow-Watching Inn" ASMR voice pack available!!',
      'time': '3 hours ago',
      'likes': 50,
      'comments': [],
    },
    {
      'username': 'Hololive Official',
      'imageUrl': 'assets/images/featured_banner2.jpg',
      'text': 'Mori Calliope "Grimoire" merch available TODAY!!',
      'time': '1 week ago',
      'likes': 140,
      'comments': [],
    },
  ];

  List<Map<String, dynamic>> posts5 = [
    {
      'username': 'Hololive Official',
      'imageUrl': 'assets/images/featured3.jpg',
      'text': 'Additionnal general ticket sales starts SOON hololive 6th fes.',
      'time': '1 hours ago',
      'likes': 500,
      'comments': [],
    },
    {
      'username': 'Hololive Official',
      'imageUrl': 'assets/images/featured4.jpg',
      'text': "Get ready for moona Hoshinova's 3D Birthday LIVE!!",
      'time': '3 hours ago',
      'likes': 50,
      'comments': [],
    },
    {
      'username': 'Hololive Official',
      'imageUrl': 'assets/images/featured5.jpg',
      'text': 'Check out the digital message boards for FBKINGDOM "ANTHEM"',
      'time': '1 week ago',
      'likes': 140,
      'comments': [],
    },
  ];

  List<Map<String, dynamic>> posts6 = [
    {
      'username': 'Hololive Official',
      'imageUrl': 'assets/images/featured3.jpg',
      'text': 'Additionnal general ticket sales starts SOON hololive 6th fes.',
      'time': '1 hours ago',
      'likes': 500,
      'comments': [],
    },
    {
      'username': 'Hololive Official',
      'imageUrl': 'assets/images/featured4.jpg',
      'text': "Get ready for moona Hoshinova's 3D Birthday LIVE!!",
      'time': '3 hours ago',
      'likes': 50,
      'comments': [],
    },
    {
      'username': 'Hololive Official',
      'imageUrl': 'assets/images/featured5.jpg',
      'text': 'Check out the digital message boards for FBKINGDOM "ANTHEM"',
      'time': '1 week ago',
      'likes': 140,
      'comments': [],
    },
  ];

  List<Map<String, dynamic>> posts7 = [
    {
      'username': 'Hololive Official',
      'imageUrl': 'assets/images/featured3.jpg',
      'text': 'Additionnal general ticket sales starts SOON hololive 6th fes.',
      'time': '1 hours ago',
      'likes': 500,
      'comments': [],
    },
    {
      'username': 'Hololive Official',
      'imageUrl': 'assets/images/featured4.jpg',
      'text': "Get ready for moona Hoshinova's 3D Birthday LIVE!!",
      'time': '3 hours ago',
      'likes': 50,
      'comments': [],
    },
    {
      'username': 'Hololive Official',
      'imageUrl': 'assets/images/featured5.jpg',
      'text': 'Check out the digital message boards for FBKINGDOM "ANTHEM"',
      'time': '1 week ago',
      'likes': 140,
      'comments': [],
    },
  ];

  List<Map<String, dynamic>> posts8 = [
    {
      'username': 'Hololive Official',
      'imageUrl': 'assets/images/featured3.jpg',
      'text': 'Additionnal general ticket sales starts SOON hololive 6th fes.',
      'time': '1 hours ago',
      'likes': 500,
      'comments': [],
    },
    {
      'username': 'Hololive Official',
      'imageUrl': 'assets/images/featured4.jpg',
      'text': "Get ready for moona Hoshinova's 3D Birthday LIVE!!",
      'time': '3 hours ago',
      'likes': 50,
      'comments': [],
    },
    {
      'username': 'Hololive Official',
      'imageUrl': 'assets/images/featured5.jpg',
      'text': 'Check out the digital message boards for FBKINGDOM "ANTHEM"',
      'time': '1 week ago',
      'likes': 140,
      'comments': [],
    },
  ];

  List<Map<String, dynamic>> posts9 = [
    {
      'username': 'Hololive Official',
      'imageUrl': 'assets/images/featured3.jpg',
      'text': 'Additionnal general ticket sales starts SOON hololive 6th fes.',
      'time': '1 hours ago',
      'likes': 500,
      'comments': [],
    },
    {
      'username': 'Hololive Official',
      'imageUrl': 'assets/images/featured4.jpg',
      'text': "Get ready for moona Hoshinova's 3D Birthday LIVE!!",
      'time': '3 hours ago',
      'likes': 50,
      'comments': [],
    },
    {
      'username': 'Hololive Official',
      'imageUrl': 'assets/images/featured5.jpg',
      'text': 'Check out the digital message boards for FBKINGDOM "ANTHEM"',
      'time': '1 week ago',
      'likes': 140,
      'comments': [],
    },
  ];

  List<Map<String, dynamic>> posts10 = [
    {
      'username': 'Hololive Official',
      'imageUrl': 'assets/images/featured3.jpg',
      'text': 'Additionnal general ticket sales starts SOON hololive 6th fes.',
      'time': '1 hours ago',
      'likes': 500,
      'comments': [],
    },
    {
      'username': 'Hololive Official',
      'imageUrl': 'assets/images/featured4.jpg',
      'text': "Get ready for moona Hoshinova's 3D Birthday LIVE!!",
      'time': '3 hours ago',
      'likes': 50,
      'comments': [],
    },
    {
      'username': 'Hololive Official',
      'imageUrl': 'assets/images/featured5.jpg',
      'text': 'Check out the digital message boards for FBKINGDOM "ANTHEM"',
      'time': '1 week ago',
      'likes': 140,
      'comments': [],
    },
  ];

  List<Map<String, dynamic>> posts11 = [
    {
      'username': 'Hololive Official',
      'imageUrl': 'assets/images/featured3.jpg',
      'text': 'Additionnal general ticket sales starts SOON hololive 6th fes.',
      'time': '1 hours ago',
      'likes': 500,
      'comments': [],
    },
    {
      'username': 'Hololive Official',
      'imageUrl': 'assets/images/featured4.jpg',
      'text': "Get ready for moona Hoshinova's 3D Birthday LIVE!!",
      'time': '3 hours ago',
      'likes': 50,
      'comments': [],
    },
    {
      'username': 'Hololive Official',
      'imageUrl': 'assets/images/featured5.jpg',
      'text': 'Check out the digital message boards for FBKINGDOM "ANTHEM"',
      'time': '1 week ago',
      'likes': 140,
      'comments': [],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Level Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: _avatarImage,
                ),
                const SizedBox(width: 10),
                Text(isJapanese ? 'レベル 1 | 0+' : 'LV 1 | 0+',
                    style: const TextStyle(fontSize: 16, color: Colors.blue)),
              ],
            ),
          ),

          // Featured Banner
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            height: 200,
            child: Stack(
              children: [
                PageView.builder(
                  onPageChanged: (index) {
                    setState(() {
                      currentBannerIndex = index;
                    });
                  },
                  controller: _pageController,
                  itemCount: bannerData.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _launchURL(bannerData[index]['url']!),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: AssetImage(bannerData[index]['image']!),
                            fit: BoxFit.cover,
                          ),
                        ),
                        height: 200,
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 8,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      bannerData.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        width: currentBannerIndex == index ? 12.0 : 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentBannerIndex == index
                              ? Colors.blue
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Filter Buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
                    style:
                        TextStyle(color: isOshiOn ? Colors.white : Colors.blue),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: isOshiOn ? Colors.white : Colors.blue,
                    backgroundColor: isOshiOn ? Colors.blue : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.blue),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      isJapanese = !isJapanese;
                    });
                  },
                  icon: Icon(
                    Icons.language,
                    color: isJapanese ? Colors.white : Colors.blue,
                  ),
                  label: Text(
                    isJapanese ? '日本語' : 'English',
                    style: TextStyle(
                        color: isJapanese ? Colors.white : Colors.blue),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: isJapanese ? Colors.white : Colors.blue,
                    backgroundColor: isJapanese ? Colors.blue : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.blue),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  ),
                ),
              ],
            ),
          ),

          // Latest News
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              isJapanese ? '最新ニュース📰' : 'Latest News📰',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: posts1.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetail(post: posts1[index]),
                      ),
                    );
                  },
                  child: Container(
                    width: 200,
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(posts1[index]['imageUrl']),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        color: Colors.black.withOpacity(0.6),
                        child: Text(
                          posts1[index]['text'],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          // Featured Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              isJapanese ? '注目👀' : 'Featured👀',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetail(post: posts[index]),
                      ),
                    );
                  },
                  child: Container(
                    width: 200,
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(posts[index]['imageUrl']),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        color: Colors.black.withOpacity(0.6),
                        child: Text(
                          posts[index]['text'],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              isJapanese ? 'リクエストを送ってください！' : 'Send in your requests!',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: posts2.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetail(post: posts2[index]),
                      ),
                    );
                  },
                  child: Container(
                    width: 200,
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(posts2[index]['imageUrl']),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        color: Colors.black.withOpacity(0.6),
                        child: Text(
                          posts2[index]['text'],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              isJapanese ? 'ホロライブの友達と一緒に' : 'My hololive friends with u',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: posts3.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetail(post: posts3[index]),
                      ),
                    );
                  },
                  child: Container(
                    width: 200,
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(posts3[index]['imageUrl']),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        color: Colors.black.withOpacity(0.6),
                        child: Text(
                          posts3[index]['text'],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              isJapanese ? 'グッズ' : 'Merch',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: posts4.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetail(post: posts4[index]),
                      ),
                    );
                  },
                  child: Container(
                    width: 200,
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(posts4[index]['imageUrl']),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        color: Colors.black.withOpacity(0.6),
                        child: Text(
                          posts4[index]['text'],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // const SizedBox(height: 20),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: Text(
          //     isJapanese ? 'ホロライブプラス' : 'Hololive Plus',
          //     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          //   ),
          // ),
          // const SizedBox(height: 10),
          // SizedBox(
          //   height: 150,
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     itemCount: posts5.length,
          //     itemBuilder: (context, index) {
          //       return GestureDetector(
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) => PostDetail(post: posts5[index]),
          //             ),
          //           );
          //         },
          //         child: Container(
          //           width: 200,
          //           margin: const EdgeInsets.symmetric(horizontal: 8.0),
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(12),
          //             image: DecorationImage(
          //               image: AssetImage(posts5[index]['imageUrl']),
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //           child: Align(
          //             alignment: Alignment.bottomCenter,
          //             child: Container(
          //               padding: const EdgeInsets.all(8.0),
          //               color: Colors.black.withOpacity(0.6),
          //               child: Text(
          //                 posts5[index]['text'],
          //                 style: const TextStyle(color: Colors.white),
          //               ),
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          // const SizedBox(height: 20),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: Text(
          //     isJapanese ? 'ホロプラスラボ' : 'holoplus Lab',
          //     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          //   ),
          // ),
          // const SizedBox(height: 10),
          // SizedBox(
          //   height: 150,
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     itemCount: posts6.length,
          //     itemBuilder: (context, index) {
          //       return GestureDetector(
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) => PostDetail(post: posts6[index]),
          //             ),
          //           );
          //         },
          //         child: Container(
          //           width: 200,
          //           margin: const EdgeInsets.symmetric(horizontal: 8.0),
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(12),
          //             image: DecorationImage(
          //               image: AssetImage(posts6[index]['imageUrl']),
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //           child: Align(
          //             alignment: Alignment.bottomCenter,
          //             child: Container(
          //               padding: const EdgeInsets.all(8.0),
          //               color: Colors.black.withOpacity(0.6),
          //               child: Text(
          //                 posts6[index]['text'],
          //                 style: const TextStyle(color: Colors.white),
          //               ),
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          // const SizedBox(height: 20),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: Text(
          //     isJapanese ? 'お祝い' : 'Celebration',
          //     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          //   ),
          // ),
          // const SizedBox(height: 10),
          // SizedBox(
          //   height: 150,
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     itemCount: posts7.length,
          //     itemBuilder: (context, index) {
          //       return GestureDetector(
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) => PostDetail(post: posts7[index]),
          //             ),
          //           );
          //         },
          //         child: Container(
          //           width: 200,
          //           margin: const EdgeInsets.symmetric(horizontal: 8.0),
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(12),
          //             image: DecorationImage(
          //               image: AssetImage(posts7[index]['imageUrl']),
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //           child: Align(
          //             alignment: Alignment.bottomCenter,
          //             child: Container(
          //               padding: const EdgeInsets.all(8.0),
          //               color: Colors.black.withOpacity(0.6),
          //               child: Text(
          //                 posts7[index]['text'],
          //                 style: const TextStyle(color: Colors.white),
          //               ),
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          // const SizedBox(height: 20),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: Text(
          //     isJapanese ? '音楽' : 'Music',
          //     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          //   ),
          // ),
          // const SizedBox(height: 10),
          // SizedBox(
          //   height: 150,
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     itemCount: posts8.length,
          //     itemBuilder: (context, index) {
          //       return GestureDetector(
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) => PostDetail(post: posts8[index]),
          //             ),
          //           );
          //         },
          //         child: Container(
          //           width: 200,
          //           margin: const EdgeInsets.symmetric(horizontal: 8.0),
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(12),
          //             image: DecorationImage(
          //               image: AssetImage(posts8[index]['imageUrl']),
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //           child: Align(
          //             alignment: Alignment.bottomCenter,
          //             child: Container(
          //               padding: const EdgeInsets.all(8.0),
          //               color: Colors.black.withOpacity(0.6),
          //               child: Text(
          //                 posts8[index]['text'],
          //                 style: const TextStyle(color: Colors.white),
          //               ),
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          // const SizedBox(height: 20),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: Text(
          //     isJapanese ? 'メディア' : 'Media',
          //     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          //   ),
          // ),
          // const SizedBox(height: 10),
          // SizedBox(
          //   height: 150,
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     itemCount: posts9.length,
          //     itemBuilder: (context, index) {
          //       return GestureDetector(
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) => PostDetail(post: posts9[index]),
          //             ),
          //           );
          //         },
          //         child: Container(
          //           width: 200,
          //           margin: const EdgeInsets.symmetric(horizontal: 8.0),
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(12),
          //             image: DecorationImage(
          //               image: AssetImage(posts9[index]['imageUrl']),
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //           child: Align(
          //             alignment: Alignment.bottomCenter,
          //             child: Container(
          //               padding: const EdgeInsets.all(8.0),
          //               color: Colors.black.withOpacity(0.6),
          //               child: Text(
          //                 posts9[index]['text'],
          //                 style: const TextStyle(color: Colors.white),
          //               ),
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          // const SizedBox(height: 20),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: Text(
          //     isJapanese ? 'アップデートとリリース' : 'Updates & Releases',
          //     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          //   ),
          // ),
          // const SizedBox(height: 10),
          // SizedBox(
          //   height: 150,
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     itemCount: posts10.length,
          //     itemBuilder: (context, index) {
          //       return GestureDetector(
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) => PostDetail(post: posts10[index]),
          //             ),
          //           );
          //         },
          //         child: Container(
          //           width: 200,
          //           margin: const EdgeInsets.symmetric(horizontal: 8.0),
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(12),
          //             image: DecorationImage(
          //               image: AssetImage(posts10[index]['imageUrl']),
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //           child: Align(
          //             alignment: Alignment.bottomCenter,
          //             child: Container(
          //               padding: const EdgeInsets.all(8.0),
          //               color: Colors.black.withOpacity(0.6),
          //               child: Text(
          //                 posts10[index]['text'],
          //                 style: const TextStyle(color: Colors.white),
          //               ),
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          // const SizedBox(height: 20),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: Text(
          //     isJapanese ? 'ここから始めましょう' : 'Start here',
          //     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          //   ),
          // ),
          // const SizedBox(height: 10),
          // SizedBox(
          //   height: 150,
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     itemCount: posts11.length,
          //     itemBuilder: (context, index) {
          //       return GestureDetector(
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) => PostDetail(post: posts11[index]),
          //             ),
          //           );
          //         },
          //         child: Container(
          //           width: 200,
          //           margin: const EdgeInsets.symmetric(horizontal: 8.0),
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(12),
          //             image: DecorationImage(
          //               image: AssetImage(posts11[index]['imageUrl']),
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //           child: Align(
          //             alignment: Alignment.bottomCenter,
          //             child: Container(
          //               padding: const EdgeInsets.all(8.0),
          //               color: Colors.black.withOpacity(0.6),
          //               child: Text(
          //                 posts11[index]['text'],
          //                 style: const TextStyle(color: Colors.white),
          //               ),
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
