import 'package:flutter/material.dart';

class RelatedTalentsPage extends StatefulWidget {
  final List<String> selectedTalents;

  const RelatedTalentsPage({Key? key, required this.selectedTalents})
      : super(key: key);

  @override
  _RelatedTalentsPageState createState() => _RelatedTalentsPageState();
}

class _RelatedTalentsPageState extends State<RelatedTalentsPage> {
  final List<Map<String, String>> talents = [
    {'name': 'Tokino Sora', 'image': 'assets/icons/icon1.png'},
    {'name': 'Robocosan', 'image': 'assets/icons/icon2.png'},
    {'name': 'AZKi', 'image': 'assets/icons/icon3.png'},
    {'name': 'Sakura Miko', 'image': 'assets/icons/icon4.png'},
    {'name': 'Hoshimachi Suisei', 'image': 'assets/icons/icon5.png'},
  ];

  late Set<String> selectedTalents;

  @override
  void initState() {
    super.initState();
    selectedTalents = widget.selectedTalents.toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Related talents', style: TextStyle(color: Colors.blue)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.blue,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8, // ปรับอัตราส่วนสำหรับพื้นที่ข้อความ
              ),
              itemCount: talents.length,
              itemBuilder: (context, index) {
                final talent = talents[index];
                final isSelected = selectedTalents.contains(talent['name']);

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedTalents.remove(talent['name']);
                      } else {
                        selectedTalents.add(talent['name']!);
                      }
                    });
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor:
                            isSelected ? Colors.blue : Colors.grey[300],
                        backgroundImage: AssetImage(talent['image']!),
                      ),
                      const SizedBox(height: 4),
                      Expanded(
                        child: Text(
                          talent['name']!,
                          style: TextStyle(
                            color: isSelected ? Colors.blue : Colors.black,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow:
                              TextOverflow.ellipsis, // ลดข้อความที่ยาวเกิน
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, selectedTalents.toList());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Confirm',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
