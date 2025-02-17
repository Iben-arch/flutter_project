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
  late int currentComments;
  late int currentLikes;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    currentComments = widget.comments;
    currentLikes = widget.likes;
  }

  void toggleLike() {
    setState(() {
      if (isLiked) {
        currentLikes--;
      } else {
        currentLikes++;
      }
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Map<String, dynamic> post = {
          'id': widget.id,
          'username': widget.username,
          'imageUrl': widget.imageUrl,
          'text': widget.text,
          'time': widget.time,
          'likes': currentLikes,
          'comments': currentComments,
        };

        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostDetailPage(post: post),
          ),
        );

        if (result != null && result is Map<String, dynamic>) {
          print(
              "Updated comments: ${result['comments']}"); // ✅ ตรวจสอบค่าที่ส่งกลับมา
          print("Updated likes: ${result['likes']}");

          setState(() {
            currentComments = result['comments'] ?? currentComments;
            currentLikes = result['likes'] ?? currentLikes;
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
                      IconButton(
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.red : Colors.black,
                          size: 20,
                        ),
                        onPressed: toggleLike,
                      ),
                      Text('$currentLikes'),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.comment, size: 16),
                      const SizedBox(width: 4),
                      Text('$currentComments'),
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
