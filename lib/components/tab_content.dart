import 'package:flutter/material.dart';
import 'package:modern_profile/constant/constant.dart';

import 'video_card.dart';

class RecentTabContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(8.0),
      children: [
        SectionHeader(title: 'Jan. 30 (Thu)'),
        Container(
          child: Text(
            '     17:00 ~',
            style: TextStyle(color: Colors.white),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.blue),
          // color: Colors.blue,
        ),
        SizedBox(
          height: 8,
        ),
        VideoCard(
          title: '【DRAWING】 STREAM',
          streamer: 'Ninomae Inanis',
          thumbnail: 'assets/videos/drawing_thumbnail.png',
          time: '01/30/2025 17:00',
          link: 'https://www.youtube.com/live/ZyacEjF4brU?si=17Qv47iKcGsU_Qny',
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          child: Text(
            '     16:00 ~',
            style: TextStyle(color: Colors.white),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.blue),
          // color: Colors.blue,
        ),
        SizedBox(
          height: 8,
        ),
        VideoCard(
          title: 'お客さんいつもより進んでますね！【＃今日のわため】',
          streamer: 'Tsunomaki Watame',
          thumbnail: 'assets/videos/watame_thumbnail.png',
          time: '01/30/2025 16:00',
          link: 'https://youtu.be/4_4Qn-N2Gjo?si=TRq-Q8JYUeVny9Lw',
        ),
      ],
    );
  }
}

class LiveTabContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(8.0),
      children: [
        SectionHeader(title: 'Jan. 29 (Wed)'),
        VideoCard(
          title: '【龍が如く６ 命の詩。】初見で挑む『龍が如く６ 命の詩。』',
          streamer: 'Yukoku Roberu',
          thumbnail: 'assets/videos/yakuza_thumbnail.png',
          time: '01/29/2025 11:00',
          link: 'https://www.youtube.com/live/I2j3jVnlWI4?si=imxH5vJydfotrlmM',
        ),
        VideoCard(
          title: '【首都高バトル】人生初のハンコンGET！！',
          streamer: 'Hakui Koyori',
          thumbnail: 'assets/videos/racing_thumbnail.png',
          time: '01/29/2025 17:00',
          link: 'https://www.youtube.com/live/8a3d-nsjdec?si=93vq3mL4lKq_KqLW',
        ),
        VideoCard(
          title: '【VALORANT】ふるっぱ w/ ありさかさん・きなこさん',
          streamer: 'Minase Rio',
          thumbnail: 'assets/videos/valorant_thumbnail.png',
          time: '01/29/2025 17:01',
          link: 'https://www.youtube.com/live/mLP6XnrcQhI?si=LxRsuzrPh9FZCfwP',
        ),
        VideoCard(
          title: '【ドンキーコング トロピカルフリーズ】クリア耐久',
          streamer: 'Nekomata Okayu',
          thumbnail: 'assets/videos/donkey_kong_thumbnail.png',
          time: '01/29/2025 17:05',
          link: 'https://www.youtube.com/live/4ViNCbtyW_E?si=teZJskgdo56rUGTE',
        ),
      ],
    );
  }
}

class StartingSoonTabContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Starting Soon Tab Content',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
