import 'package:flutter/material.dart';
import 'package:modern_profile/constant/constant.dart';
import '../components/home_img.dart';
import '../components/profile_menu.dart';

class HomePage extends StatelessWidget {
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
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.star, color: Colors.white),
                ),
                SizedBox(width: 10),
                Text('LV 1 | 0+',
                    style: TextStyle(fontSize: 16, color: Colors.blue)),
              ],
            ),
          ),

          // Featured Banner
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(
                    'assets/featured_banner.jpg'), // Replace with your image
                fit: BoxFit.cover,
              ),
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
                  child: Text('My Oshi off'),
                ),
                DropdownButton<String>(
                  value: 'English',
                  items: ['English', '日本語']
                      .map((lang) => DropdownMenuItem(
                            child: Text(lang),
                            value: lang,
                          ))
                      .toList(),
                  onChanged: (value) {},
                ),
              ],
            ),
          ),

          // Latest News
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Latest News📰',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
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
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.new_releases, color: Colors.orange),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'New hololive Minecraft Server',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'A brand new server exclusively for hololive...',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'wow, I can\'t wait to see~~~',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    Row(
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

          SizedBox(height: 20),

          // Featured Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Featured👀',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                FeaturedCard(
                    image: 'assets/featured1.jpg',
                    title: 'Sakamata Chloe\'s final stream'),
                FeaturedCard(
                    image: 'assets/featured2.jpg',
                    title: 'Another Exciting Event'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FeaturedCard extends StatelessWidget {
  final String image;
  final String title;

  const FeaturedCard({required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(left: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
