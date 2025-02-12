import 'package:flutter/material.dart';
import 'dart:html'; // สำหรับ Flutter Web
import 'related_talents_page.dart'; // นำเข้าหน้าสำหรับเลือก Related Talents

class PostThreadPage extends StatefulWidget {
  const PostThreadPage({super.key});

  @override
  _PostThreadPageState createState() => _PostThreadPageState();
}

class _PostThreadPageState extends State<PostThreadPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _detailsController = TextEditingController();
  String? _selectedImage;
  List<String> _relatedTalents = []; // รายการ Talent ที่เลือก
  int _currentStep = 0;

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
          _selectedImage = reader.result as String?;
        });
      });
    });
  }

  Future<void> _selectRelatedTalents() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => RelatedTalentsPage(
                selectedTalents: [],
              )),
    );
    if (result != null && result is List<String>) {
      setState(() {
        _relatedTalents = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Post a thread', style: TextStyle(color: Colors.blue)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.blue),
        leading: _currentStep == 1
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.blue),
                onPressed: () {
                  setState(() {
                    _currentStep = 0;
                  });
                },
              )
            : null,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.blue),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepTapped: (step) {
          setState(() {
            _currentStep = step;
          });
        },
        controlsBuilder: (context, details) {
          return const SizedBox.shrink();
        },
        steps: [
          Step(
            title: const Text('1/2'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Title', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: 'Enter a title to continue!',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Details', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                TextField(
                  controller: _detailsController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText:
                        'Add details to your thread or paste a link here!',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Image', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Upload Image'),
                ),
                const SizedBox(height: 16),
                if (_selectedImage != null)
                  Image.network(
                    _selectedImage!,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _currentStep = 1;
                      });
                    },
                    child: const Text('Next'),
                  ),
                ),
              ],
            ),
            isActive: _currentStep == 0,
          ),
          Step(
            title: const Text('2/2'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Category', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  items: [
                    DropdownMenuItem(
                        value: 'Steam/Video', child: Text('Steam/Video')),
                    DropdownMenuItem(value: 'Event', child: Text('Event')),
                    DropdownMenuItem(value: 'Collab', child: Text('Collab')),
                    DropdownMenuItem(value: 'Clips', child: Text('Clips')),
                    DropdownMenuItem(value: 'Fan art', child: Text('Fan art')),
                    DropdownMenuItem(value: 'Music', child: Text('Music')),
                    DropdownMenuItem(value: 'Merch', child: Text('Merch')),
                  ],
                  onChanged: (value) {},
                  decoration: const InputDecoration(
                    hintText: 'Select a category',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Related talents', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: _selectRelatedTalents,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue),
                    ),
                    child: Text(
                      _relatedTalents.isEmpty
                          ? 'Tap to select related talents'
                          : _relatedTalents.join(', '),
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
            isActive: _currentStep == 1,
          ),
        ],
      ),
      bottomNavigationBar: _currentStep == 1
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_titleController.text.isNotEmpty &&
                      _detailsController.text.isNotEmpty) {
                    Map<String, dynamic> newPost = {
                      'username': 'You',
                      'imageUrl': _selectedImage ?? '',
                      'text': _titleController.text,
                      'time': DateTime.now().toString(),
                      'likes': 0,
                      'comments': 0,
                      'relatedTalents': _relatedTalents,
                    };
                    Navigator.pop(context, newPost);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text('Please complete all fields to continue.')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Post',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            )
          : null,
    );
  }
}
