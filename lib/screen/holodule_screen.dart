import 'package:flutter/material.dart';

import '../components/video_card.dart';

class HoLoDule extends StatelessWidget {
  const HoLoDule({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Recent',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'LIVE!',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Starting Soon',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(8.0),
              children: [
                SectionHeader(title: 'Jan. 29 (Wed)'),
                VideoCard(
                  title: '【龍が如く６ 命の詩。】初見で挑む『龍が如く６ 命の詩。』',
                  streamer: 'Yukoku Roberu',
                  thumbnail: 'assets/videos/yakuza_thumbnail.png',
                  time: '01/29/2025 11:00',
                  link:
                      'https://www.youtube.com/live/I2j3jVnlWI4?si=imxH5vJydfotrlmM',
                ),
                VideoCard(
                  title: '【首都高バトル】人生初のハンコンGET！！',
                  streamer: 'Hakui Koyori',
                  thumbnail: 'assets/videos/racing_thumbnail.png',
                  time: '01/29/2025 17:00',
                  link:
                      'https://www.youtube.com/live/8a3d-nsjdec?si=93vq3mL4lKq_KqLW',
                ),
                VideoCard(
                  title: '【VALORANT】ふるっぱ w/ ありさかさん・きなこさん',
                  streamer: 'Minase Rio',
                  thumbnail: 'assets/videos/valorant_thumbnail.png',
                  time: '01/29/2025 17:01',
                  link:
                      'https://www.youtube.com/live/mLP6XnrcQhI?si=LxRsuzrPh9FZCfwP',
                ),
                VideoCard(
                  title: '【ドンキーコング トロピカルフリーズ】クリア耐久',
                  streamer: 'Nekomata Okayu',
                  thumbnail: 'assets/videos/donkey_kong_thumbnail.png',
                  time: '01/29/2025 17:05',
                  link:
                      'https://www.youtube.com/live/4ViNCbtyW_E?si=teZJskgdo56rUGTE',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
