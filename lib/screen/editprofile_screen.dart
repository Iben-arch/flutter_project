import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../components/oshi_avatar.dart';
import 'setting_page.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Icon(Icons.water_drop, size: 50, color: Colors.blue),
              ),
              SizedBox(height: 10),
              Text("Nora",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text("holoplus points LV 1 | 0+",
                  style: TextStyle(color: Colors.grey)),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.blue[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text("My Oshi",
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(backgroundColor: Colors.blue, radius: 20),
                  SizedBox(width: 10),
                  CircleAvatar(backgroundColor: Colors.red, radius: 20),
                  SizedBox(width: 10),
                  CircleAvatar(backgroundColor: Colors.pink, radius: 20),
                  SizedBox(width: 10),
                  CircleAvatar(backgroundColor: Colors.purple, radius: 20),
                  SizedBox(width: 10),
                  CircleAvatar(backgroundColor: Colors.orange, radius: 20),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bookmark, color: Colors.blue),
                  SizedBox(width: 5),
                  Text("Saved"),
                  SizedBox(width: 20),
                  Icon(Icons.forum, color: Colors.blue),
                  SizedBox(width: 5),
                  Text("My threads"),
                  SizedBox(width: 20),
                  Icon(Icons.comment, color: Colors.blue),
                  SizedBox(width: 5),
                  Text("My comments"),
                ],
              ),
            ],
          ),
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              icon: Icon(Icons.settings, color: Colors.black, size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
