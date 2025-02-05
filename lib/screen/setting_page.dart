import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isSwitched = true; // ค่าตั้งต้นของ Switch
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings / Information",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.blue,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.blue[500],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("App Information",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 10),
            Container(
              constraints: BoxConstraints(maxHeight: 35),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: const ListTile(
                title: Text("Version"),
                trailing: Text(
                  "2.3.4 (182)",
                  style: TextStyle(fontSize: 16),
                ),
                textColor: Colors.blue,
                contentPadding: EdgeInsets.symmetric(
                    vertical: 0, horizontal: 10), // ลด padding
                visualDensity: VisualDensity(vertical: -4),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              constraints: BoxConstraints(maxHeight: 35),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: const ListTile(
                title: Text("Open Source Licenses"),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: Colors.blue,
                ),
                textColor: Colors.blue,
                contentPadding: EdgeInsets.symmetric(
                    vertical: 0, horizontal: 10), // ลด padding
                visualDensity: VisualDensity(vertical: -4),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Settings",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 10),
            Container(
              constraints: BoxConstraints(maxHeight: 35),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: const ListTile(
                title: Text("Blocked Users"),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: Colors.blue,
                ),
                textColor: Colors.blue,
                contentPadding: EdgeInsets.symmetric(
                    vertical: 0, horizontal: 10), // ลด padding
                visualDensity: VisualDensity(vertical: -4),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              constraints: BoxConstraints(maxHeight: 35),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: const ListTile(
                title: Text(
                  "UI Language Settings",
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: Colors.blue,
                ), // ปรับขนาดไอคอน
                textColor: Colors.blue,
                contentPadding: EdgeInsets.symmetric(
                    vertical: 0, horizontal: 10), // ลด padding
                visualDensity:
                    VisualDensity(vertical: -4), // ลดความสูงของ ListTile
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              constraints: BoxConstraints(maxHeight: 35),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: const ListTile(
                title: Text("Notifications"),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: Colors.blue,
                ),
                textColor: Colors.blue,
                contentPadding: EdgeInsets.symmetric(
                    vertical: 0, horizontal: 10), // ลด padding
                visualDensity: VisualDensity(vertical: -4),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              constraints: BoxConstraints(maxHeight: 35),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: const ListTile(
                title: Text("Community"),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: Colors.blue,
                ),
                textColor: Colors.blue,
                contentPadding: EdgeInsets.symmetric(
                    vertical: 0, horizontal: 10), // ลด padding
                visualDensity: VisualDensity(vertical: -4),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              constraints: BoxConstraints(maxHeight: 35),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10), // ลด padding ด้านข้าง
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // จัดวางข้อความและสวิตช์
                  children: [
                    const Text(
                      "Receive emails from holoplus",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16), // ✅ ทำให้ข้อความเป็นสีน้ำเงิน
                    ),
                    Transform.scale(
                      scale: 0.7, // ✅ ลดขนาดของ Switch
                      child: Switch(
                        value: isSwitched,
                        onChanged: (bool value) {
                          setState(() {
                            isSwitched = value;
                          });
                        },
                        activeColor:
                            Colors.blue, // ✅ เปลี่ยนสีของ Switch เมื่อเปิด
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Support",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 10),
            Container(
              constraints: BoxConstraints(maxHeight: 35),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: const ListTile(
                title: Text("Contact Us"),
                trailing: Icon(
                  Icons.open_in_new,
                  size: 18,
                  color: Colors.blue,
                ),
                textColor: Colors.blue,
                contentPadding: EdgeInsets.symmetric(
                    vertical: 0, horizontal: 10), // ลด padding
                visualDensity: VisualDensity(vertical: -4),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              constraints: BoxConstraints(maxHeight: 35),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: const ListTile(
                title: Text("FAQ"),
                textColor: Colors.blue,
                trailing: Icon(
                  Icons.open_in_new,
                  size: 18,
                  color: Colors.blue,
                ),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 0, horizontal: 10), // ลด padding
                visualDensity: VisualDensity(vertical: -4),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Additional information",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
            Container(
              constraints: BoxConstraints(maxHeight: 35),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: const ListTile(
                title: Text("Terms of Service"),
                textColor: Colors.blue,
                trailing: Icon(
                  Icons.open_in_new,
                  size: 18,
                  color: Colors.blue,
                ),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 0, horizontal: 10), // ลด padding
                visualDensity: VisualDensity(vertical: -4),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              constraints: BoxConstraints(maxHeight: 35),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: const ListTile(
                title: Text("Privacy Policy"),
                textColor: Colors.blue,
                trailing: Icon(
                  Icons.open_in_new,
                  size: 18,
                  color: Colors.blue,
                ),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 0, horizontal: 10), // ลด padding
                visualDensity: VisualDensity(vertical: -4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
