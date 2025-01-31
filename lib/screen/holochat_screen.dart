import 'dart:io';

import 'package:flutter/material.dart';

import '../components/post_card.dart';

class HololiveChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
          Expanded(
            child: ListView(
              children: [
                PostCard(
                  username: 'Abby_Nicole',
                  imageUrl: '',
                  text: '2024 ME ARE SUCH A FREAKY HELP ME',
                  time: '01/28/2025 18:35',
                  likes: 11,
                  comments: 1,
                ),
                PostCard(
                  username: 'Sigismund',
                  imageUrl: 'assets/images/Suichan.jpg',
                  text: '',
                  time: '',
                  likes: 0,
                  comments: 0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
