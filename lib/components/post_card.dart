import 'package:flutter/material.dart';
import '../screen/post_detail_page.dart';

class PostCard extends StatefulWidget {
  final String id;
  final String username;
  final String imageUrl;
  final String text;
  final String time;
  final int likes;
  final int comments;

  const PostCard({
    Key? key,
    required this.id,
    required this.username,
    required this.imageUrl,
    required this.text,
    required this.time,
    required this.likes,
    required this.comments,
  }) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late int currentComments; // ✅ เก็บจำนวนคอมเมนต์ที่อัปเดตได้

  @override
  void initState() {
    super.initState();
    currentComments = widget.comments; // กำหนดค่าจำนวนคอมเมนต์เริ่มต้น
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // สร้าง Map สำหรับ post
        Map<String, dynamic> post = {
          'id': widget.id,
          'username': widget.username,
          'imageUrl': widget.imageUrl,
          'text': widget.text,
          'time': widget.time,
          'likes': widget.likes,
          'comments': currentComments,
        };

        final updatedComments = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostDetailPage(
              post: post, // ส่ง post ไป
            ),
          ),
        );

        // ✅ ถ้ามีจำนวนคอมเมนต์อัปเดต ให้ setState เพื่อเปลี่ยนค่า
        if (updatedComments != null) {
          setState(() {
            currentComments = updatedComments;
          });
        }
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
                  const CircleAvatar(child: Icon(Icons.person)),
                  const SizedBox(width: 8),
                  Text(widget.username,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 10),
              if (widget.imageUrl.isNotEmpty) ...[
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(child: Text('Failed to load image'));
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],
              if (widget.text.isNotEmpty)
                Text(widget.text, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text(widget.time,
                  style: const TextStyle(color: Colors.grey, fontSize: 12)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.favorite_border, size: 16),
                      const SizedBox(width: 4),
                      Text('${widget.likes}'),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.comment, size: 16),
                      const SizedBox(width: 4),
                      Text(
                          '$currentComments'), // ✅ แสดงจำนวนคอมเมนต์ที่อัปเดตได้
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
