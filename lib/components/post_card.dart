import 'package:flutter/material.dart';
import '../screen/post_detail_page.dart';

class PostCard extends StatelessWidget {
  final String username;
  final String imageUrl;
  final String text;
  final String time;
  final int likes;
  final int comments;

  const PostCard({
    Key? key,
    required this.username,
    required this.imageUrl,
    required this.text,
    required this.time,
    required this.likes,
    required this.comments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // เมื่อกดการ์ด ให้ไปที่หน้า PostDetailPage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostDetailPage(
              username: username,
              imageUrl: imageUrl,
              text: text,
              time: time,
              likes: likes,
              comments: comments,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    username,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (imageUrl.isNotEmpty) ...[
                AspectRatio(
                  aspectRatio: 16 / 9, // อัตราส่วนของภาพ
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover, // ปรับให้ภาพเต็มพื้นที่
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(child: Text('Failed to load image'));
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],
              if (text.isNotEmpty)
                Text(
                  text,
                  style: const TextStyle(fontSize: 16),
                ),
              const SizedBox(height: 10),
              Text(
                time,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.favorite_border, size: 16),
                      const SizedBox(width: 4),
                      Text('$likes'),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.comment, size: 16),
                      const SizedBox(width: 4),
                      Text('$comments'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
