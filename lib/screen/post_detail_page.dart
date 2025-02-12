import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/reply_page.dart';

class PostDetailPage extends StatefulWidget {
  final String username;
  final String imageUrl;
  final String text;
  final String time;
  final int likes;
  final int comments;

  const PostDetailPage({
    Key? key,
    required this.username,
    required this.imageUrl,
    required this.text,
    required this.time,
    required this.likes,
    required this.comments,
  }) : super(key: key);

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  List<Map<String, dynamic>> commentList = [];
  TextEditingController _commentController = TextEditingController();
  String? _base64Image;

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  Future<void> _saveComments() async {
    final prefs = await SharedPreferences.getInstance();
    final commentsJson = jsonEncode(commentList);
    await prefs.setString('comments', commentsJson);
  }

  Future<void> _loadComments() async {
    final prefs = await SharedPreferences.getInstance();
    final commentsJson = prefs.getString('comments');
    if (commentsJson != null) {
      setState(() {
        commentList = List<Map<String, dynamic>>.from(jsonDecode(commentsJson));
      });
    }
  }

  void _addComment() {
    if (_commentController.text.isNotEmpty || _base64Image != null) {
      setState(() {
        commentList.add({
          'id': DateTime.now().millisecondsSinceEpoch, // สร้าง id เฉพาะ
          'username': 'User${commentList.length + 1}',
          'text': _commentController.text,
          'image': _base64Image,
          'likes': 0,
          'isLiked': false,
          'replies': [],
          'timestamp': DateTime.now().toString(),
        });
        _commentController.clear();
        _base64Image = null;
        _saveComments();
      });
    }
  }

  void _toggleLikeComment(int index) {
    setState(() {
      commentList[index]['isLiked'] = !commentList[index]['isLiked'];
      commentList[index]['likes'] += commentList[index]['isLiked'] ? 1 : -1;
      _saveComments();
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _base64Image = base64Encode(bytes);
      });
    }
  }

  void _navigateToReplyPage(int commentIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReplyPage(
          commentIndex: commentIndex,
          comment: commentList[commentIndex],
          username: commentList[commentIndex]['username'],
          commentText: commentList[commentIndex]['text'],
        ),
      ),
    );
  }

  // ฟังก์ชันช่วยแปลง timestamp ให้อยู่ในรูปแบบอ่านง่าย
  String _formatTimestamp(String timestamp) {
    final dateTime = DateTime.parse(timestamp);
    return "${dateTime.hour}:${dateTime.minute} - ${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.blue),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(12.0),
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(child: Icon(Icons.person)),
                        const SizedBox(width: 8),
                        Text(widget.username,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (widget.imageUrl.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child:
                            Image.network(widget.imageUrl, fit: BoxFit.cover),
                      ),
                    const SizedBox(height: 10),
                    Text(widget.text, style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        '${commentList.length} Comments',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: commentList.length,
                      itemBuilder: (context, index) {
                        final comment = commentList[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const CircleAvatar(
                                        child: Icon(Icons.person)),
                                    const SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          comment['username'],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          _formatTimestamp(
                                              comment['timestamp']),
                                          style: const TextStyle(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                if (comment['image'] != null)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.memory(
                                      base64Decode(comment['image']),
                                      width: double.infinity,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                const SizedBox(height: 10),
                                Text(
                                  comment['text'],
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.reply,
                                              color: Colors.blue),
                                          onPressed: () =>
                                              _navigateToReplyPage(index),
                                        ),
                                        Text(
                                          '${comment['replies'].length} Replies',
                                          style: const TextStyle(
                                              color: Colors.blue),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            comment['isLiked']
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: comment['isLiked']
                                                ? Colors.red
                                                : Colors.black,
                                          ),
                                          onPressed: () =>
                                              _toggleLikeComment(index),
                                        ),
                                        Text('${comment['likes']} Likes'),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
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
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _commentController,
                          decoration: InputDecoration(
                            hintText: 'Write a comment...',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                            ),
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.image,
                                      color: Colors.blue),
                                  onPressed: _pickImage,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.send,
                                      color: Colors.blue),
                                  onPressed: _addComment,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (_base64Image != null)
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.memory(
                          base64Decode(_base64Image!),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
