import 'dart:async';

import 'package:flutter/material.dart';
import '../components/detail_card.dart';
import '../components/home_img.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isJapanese = false;
  int currentBannerIndex = 0;
  Timer? _bannerTimer;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentBannerIndex);
    _startBannerTimer();
  }

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
      'url': 'https://hololivemeet.hololivepro.com/banner5'
    },
  ];

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
                const CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/profile_image.jpg'),
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
            height: 200,
          ),

          // Filter Buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(isJapanese ? '私の推しオフ' : 'My Oshi off'),
                ),
                DropdownButton<String>(
                  value: isJapanese ? '日本語' : 'English',
                  items: ['English', '日本語']
                      .map((lang) => DropdownMenuItem(
                            child: Text(lang),
                            value: lang,
                          ))
                      .toList(),
                  onChanged: toggleLanguage,
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
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.new_releases, color: Colors.orange),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        isJapanese
                            ? '新しいホロライブのマインクラフトサーバー'
                            : 'New hololive Minecraft Server',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  isJapanese
                      ? 'ホロライブ専用の新しいサーバー...'
                      : 'A brand new server exclusively for hololive...',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isJapanese ? 'わあ、楽しみ〜〜〜' : 'wow, I can\'t wait to see~~~',
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                    const Row(
                      children: [
                        Icon(Icons.favorite, color: Colors.red),
                        SizedBox(width: 5),
                        Text('3,370'),
                      ],
                    )
                  ],
                )
              ],
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
          Container(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                FeaturedCard(
                  image: 'assets/images/featured1.jpg',
                  title: isJapanese
                      ? '沙花叉クロエの卒業配信'
                      : 'Sakamata Chloe\'s final stream',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          title: isJapanese
                              ? '沙花叉クロエの卒業配信'
                              : 'Sakamata Chloe\'s final stream',
                          image: 'assets/images/featured1.jpg',
                        ),
                      ),
                    );
                  },
                ),
                FeaturedCard(
                  image: 'assets/images/featured2.jpg',
                  title: isJapanese
                      ? 'もう一つのエキサイティングなイベント'
                      : 'Another Exciting Event',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          title: isJapanese
                              ? 'もう一つのエキサイティングなイベント'
                              : 'Another Exciting Event',
                          image: 'assets/images/featured2.jpg',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
