import 'package:flutter/material.dart';

class PostDetail extends StatefulWidget {
  final Map<String, dynamic> post;

  const PostDetail({Key? key, required this.post}) : super(key: key);

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  final TextEditingController _commentController = TextEditingController();

  void _addComment() {
    if (_commentController.text.isNotEmpty) {
      setState(() {
        widget.post['comments'].add(_commentController.text);
        _commentController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(widget.post['imageUrl'],
                width: double.infinity, height: 200, fit: BoxFit.cover),
            SizedBox(height: 10),
            Text(widget.post['text'],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(widget.post['time'], style: TextStyle(color: Colors.grey)),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.favorite, color: Colors.red),
                SizedBox(width: 5),
                Text(widget.post['likes'].toString()),
              ],
            ),
            SizedBox(height: 20),
            Text("Comments:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: widget.post['comments'].length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.person),
                    title: Text(widget.post['comments'][index]),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(labelText: "Add a comment..."),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: _addComment,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
