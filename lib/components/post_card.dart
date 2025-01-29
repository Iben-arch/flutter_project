import 'dart:io';

import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String username;
  final String imageUrl;
  final String text;
  final String time;
  final int likes;
  final int comments;

  const PostCard({
    required this.username,
    required this.imageUrl,
    required this.text,
    required this.time,
    required this.likes,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.all(12.0),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                SizedBox(width: 12),
                Text(
                  username,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            if (imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            SizedBox(height: 12),
            Text(
              text,
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  time,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Row(
                  children: [
                    Icon(Icons.favorite, color: Colors.red),
                    SizedBox(width: 6),
                    Text(likes.toString(), style: TextStyle(fontSize: 14)),
                    SizedBox(width: 16),
                    Icon(Icons.comment, color: Colors.grey),
                    SizedBox(width: 6),
                    Text(comments.toString(), style: TextStyle(fontSize: 14)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
