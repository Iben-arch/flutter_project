import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReplyPage extends StatefulWidget {
  final Map<String, dynamic> comment;

  const ReplyPage(
      {Key? key,
      required this.comment,
      required int commentIndex,
      required String username,
      required String commentText})
      : super(key: key);

  @override
  _ReplyPageState createState() => _ReplyPageState();
}

class _ReplyPageState extends State<ReplyPage> {
  TextEditingController replyController = TextEditingController();
  List<Map<String, dynamic>> replies = [];
  int likes = 0;

  @override
  void initState() {
    super.initState();
    _loadReplies();
    _loadLikes();
  }

  Future<void> _loadReplies() async {
    final prefs = await SharedPreferences.getInstance();
    final storedReplies =
        prefs.getStringList('replies_${widget.comment['id']}') ?? [];
    debugPrint(
        'Loading replies for ID: ${widget.comment['id']} -> $storedReplies');
    setState(() {
      try {
        replies = storedReplies
            .map((e) => jsonDecode(e) as Map<String, dynamic>)
            .toList();
      } catch (e) {
        debugPrint('Error decoding replies: $e');
        replies = [];
      }
    });
  }

  Future<void> _saveReply(String replyText) async {
    final prefs = await SharedPreferences.getInstance();
    final newReply = {
      'text': replyText,
      'timestamp': DateTime.now().toIso8601String(),
      'likes': 0
    };
    replies.add(newReply);
    debugPrint(
        'Saving replies for ID: ${widget.comment['id']} -> ${jsonEncode(replies)}');
    await prefs.setStringList('replies_${widget.comment['id']}',
        replies.map((e) => jsonEncode(e)).toList());
    setState(() {
      replyController.clear();
    });
  }

  Future<void> _loadLikes() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      likes = prefs.getInt('likes_${widget.comment['id']}') ?? 0;
    });
  }

  Future<void> _increaseLikes() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      likes++;
    });
    await prefs.setInt('likes_${widget.comment['id']}', likes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reply to Comment',
            style: TextStyle(color: Colors.blue)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.blue),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.blue),
                      ),
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(child: Icon(Icons.person)),
                              const SizedBox(width: 8),
                              Text(widget.comment['username'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(widget.comment['text'],
                              style: const TextStyle(fontSize: 16)),
                          if (widget.comment['image'] != null) ...[
                            const SizedBox(height: 10),
                            Image.memory(base64Decode(widget.comment['image']),
                                width: 100, height: 100),
                          ],
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Posted on: ${widget.comment['timestamp']}',
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 12)),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.thumb_up,
                                        color: Colors.blue),
                                    onPressed: _increaseLikes,
                                  ),
                                  Text('$likes'),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    for (var reply in replies)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blue),
                        ),
                        padding: const EdgeInsets.all(12.0),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            const CircleAvatar(child: Icon(Icons.person)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(reply['text'],
                                      style: const TextStyle(fontSize: 16)),
                                  const SizedBox(height: 5),
                                  Text(reply['timestamp'],
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 12)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey)),
            ),
            child: Row(
              children: [
                const CircleAvatar(child: Icon(Icons.person)),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: replyController,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      hintText: 'Write a reply...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: () {
                    if (replyController.text.isNotEmpty) {
                      _saveReply(replyController.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
