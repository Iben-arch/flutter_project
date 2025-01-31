import 'package:flutter/material.dart';

import '../components/tab_content.dart';
import '../components/video_card.dart';

class HoLoDule extends StatefulWidget {
  const HoLoDule({super.key});

  @override
  State<HoLoDule> createState() => _HoLoDuleState();
}

class _HoLoDuleState extends State<HoLoDule> {
  String selectedTab = 'LIVE!';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedTab = 'Recent';
                    });
                  },
                  child: Text(
                    'Recent',
                    style: TextStyle(
                      color: selectedTab == 'Recent'
                          ? Colors.white
                          : Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedTab = 'LIVE!';
                    });
                  },
                  child: Text(
                    'LIVE!',
                    style: TextStyle(
                      color: selectedTab == 'LIVE!'
                          ? Colors.white
                          : Colors.white70,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedTab = 'Starting Soon';
                    });
                  },
                  child: Text(
                    'Starting Soon',
                    style: TextStyle(
                      color: selectedTab == 'Starting Soon'
                          ? Colors.white
                          : Colors.white70,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: selectedTab == 'Recent'
                ? RecentTabContent()
                : selectedTab == 'LIVE!'
                    ? LiveTabContent()
                    : StartingSoonTabContent(),
          ),
        ],
      ),
    );
  }
}
