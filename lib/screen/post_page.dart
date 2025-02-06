import 'package:flutter/material.dart';
import 'dart:html'; // สำหรับ Flutter Web

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController _textController = TextEditingController();
  String? _selectedImage;

  // ฟังก์ชันเลือกภาพจากแกลเลอรี (สำหรับ Flutter Web)
  void _pickImage() {
    FileUploadInputElement uploadInput = FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final file = uploadInput.files!.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        setState(() {
          _selectedImage = reader.result as String?; // เก็บ Base64 URL
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Post a thread',
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ช่องกรอกข้อความโพสต์
            TextField(
              controller: _textController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'What\'s on your mind?',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // ส่วนสำหรับเลือกภาพจากแกลเลอรี
            GestureDetector(
              onTap: _pickImage, // เรียกฟังก์ชันเลือกภาพ
              child: _selectedImage == null
                  ? Container(
                      height: 150,
                      color: Colors.grey[300],
                      child: const Center(
                        child: Text('Tap to add image'),
                      ),
                    )
                  : Image.network(
                      _selectedImage!, // แสดงภาพจาก Base64 URL
                      height: 150,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(height: 20),
            // ปุ่มสำหรับโพสต์
            ElevatedButton(
              onPressed: () {
                String postText = _textController.text;
                if (postText.isNotEmpty || _selectedImage != null) {
                  // สร้างข้อมูลโพสต์ใหม่
                  Map<String, dynamic> newPost = {
                    'username': 'You', // สามารถเปลี่ยนเป็นระบบล็อกอินในอนาคต
                    'imageUrl': _selectedImage ?? '',
                    'text': postText,
                    'time': DateTime.now().toString(),
                    'likes': 0,
                    'comments': 0,
                  };

                  // ส่งโพสต์กลับไปยังหน้าหลัก
                  Navigator.pop(context, newPost);
                } else {
                  // แจ้งเตือนถ้าข้อมูลว่าง
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Please write something or add an image to post.'),
                    ),
                  );
                }
              },
              child: const Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
}
