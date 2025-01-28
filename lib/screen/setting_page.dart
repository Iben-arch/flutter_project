import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings / Information",
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.blue[100],
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("App Information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ListTile(
              title: Text("Version"),
              trailing: Text("2.3.4 (182)"),
            ),
            ListTile(
              title: Text("Open Source Licenses"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            SizedBox(height: 20),
            Text("Settings",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ListTile(
                title: Text("Blocked Users"),
                trailing: Icon(Icons.arrow_forward_ios)),
            ListTile(
                title: Text("UI Language Settings"),
                trailing: Icon(Icons.arrow_forward_ios)),
            ListTile(
                title: Text("Notifications"),
                trailing: Icon(Icons.arrow_forward_ios)),
            ListTile(
                title: Text("Community"),
                trailing: Icon(Icons.arrow_forward_ios)),
            SwitchListTile(
              title: Text("Receive emails from holoplus"),
              value: true,
              onChanged: (bool value) {},
            ),
            SizedBox(height: 20),
            Text("Support",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ListTile(
                title: Text("Contact Us"), trailing: Icon(Icons.open_in_new)),
            ListTile(title: Text("FAQ"), trailing: Icon(Icons.open_in_new)),
            SizedBox(height: 20),
            Text("Additional information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ListTile(
                title: Text("Terms of Service"),
                trailing: Icon(Icons.open_in_new)),
            ListTile(
                title: Text("Privacy Policy"),
                trailing: Icon(Icons.open_in_new)),
          ],
        ),
      ),
    );
  }
}
