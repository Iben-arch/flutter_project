import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/reply_page.dart';

class PostDetailPage extends StatefulWidget {
  final Map<String, dynamic> post;

  const PostDetailPage({Key? key, required this.post}) : super(key: key);

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
    await prefs.setString('comments_${widget.post['id']}',
        commentsJson); // เก็บคอมเมนต์ตาม ID โพสต์
  }

  Future<void> _loadComments() async {
    final prefs = await SharedPreferences.getInstance();
    final commentsJson = prefs
        .getString('comments_${widget.post['id']}'); // โหลดคอมเมนต์ของโพสต์นี้
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
          'id': DateTime.now().millisecondsSinceEpoch,
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

  @override
  void dispose() {
    Navigator.pop(
        context, commentList.length); // ส่งค่าคอมเมนต์กลับไปที่ PostCard
    super.dispose();
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

  String _formatTimestamp(String timestamp) {
    final dateTime = DateTime.parse(timestamp);
    return "${dateTime.hour}:${dateTime.minute} - ${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }

  void _navigateToReplyPage(int commentIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReplyPage(
          commentIndex: commentIndex, // ส่งคอมเมนต์ที่เลือกไปยังหน้า ReplyPage
          comment: commentList[commentIndex], // ส่งข้อมูลคอมเมนต์
          username: commentList[commentIndex]['username'], // ส่งชื่อผู้ใช้
          commentText: commentList[commentIndex]['text'], // ส่งข้อความคอมเมนต์
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.blue),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12.0),
              children: [
                // ส่วนของโพสต์
                Row(
                  children: [
                    const CircleAvatar(child: Icon(Icons.person)),
                    const SizedBox(width: 8),
                    Text(widget.post['username'],
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 10),
                if (widget.post['imageUrl'].isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(widget.post['imageUrl'],
                        fit: BoxFit.cover),
                  ),
                const SizedBox(height: 10),
                Text(widget.post['text'], style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('${commentList.length} Comments',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
                // ส่วนของคอมเมนต์
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: commentList.length,
                  itemBuilder: (context, index) {
                    final comment = commentList[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(child: Icon(Icons.person)),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(comment['username'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text(_formatTimestamp(comment['timestamp']),
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.grey)),
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
                                    fit: BoxFit.cover),
                              ),
                            const SizedBox(height: 10),
                            Text(comment['text'],
                                style: const TextStyle(fontSize: 14)),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.reply,
                                          color: Colors.blue),
                                      onPressed: () => _navigateToReplyPage(
                                          index), // เมื่อกดไปยัง ReplyPage
                                    ),
                                    Text('${comment['replies'].length} Replies',
                                        style: const TextStyle(
                                            color: Colors.blue)),
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
      bottomNavigationBar:
          _buildCommentInput(), // ใช้ _buildCommentInput สำหรับการป้อนคอมเมนต์
      resizeToAvoidBottomInset: true, // ป้องกัน UI ทับกับคีย์บอร์ด
    );
  }

  Widget _buildCommentInput() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
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
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.image, color: Colors.blue),
                      onPressed: _pickImage,
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: Colors.blue),
                      onPressed: _addComment,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
