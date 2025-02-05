import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings / Information",
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.blue[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("App Information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const ListTile(
              title: Text("Version"),
              trailing: Text("2.3.4 (182)"),
            ),
            const ListTile(
              title: Text("Open Source Licenses"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            const SizedBox(height: 20),
            const Text("Settings",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const ListTile(
                title: Text("Blocked Users"),
                trailing: Icon(Icons.arrow_forward_ios)),
            const ListTile(
                title: Text("UI Language Settings"),
                trailing: Icon(Icons.arrow_forward_ios)),
            const ListTile(
                title: Text("Notifications"),
                trailing: Icon(Icons.arrow_forward_ios)),
            const ListTile(
                title: Text("Community"),
                trailing: Icon(Icons.arrow_forward_ios)),
            SwitchListTile(
              title: const Text("Receive emails from holoplus"),
              value: true,
              onChanged: (bool value) {},
            ),
            const SizedBox(height: 20),
            const Text("Support",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const ListTile(
                title: Text("Contact Us"), trailing: Icon(Icons.open_in_new)),
            const ListTile(
                title: Text("FAQ"), trailing: Icon(Icons.open_in_new)),
            const SizedBox(height: 20),
            const Text("Additional information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const ListTile(
                title: Text("Terms of Service"),
                trailing: Icon(Icons.open_in_new)),
            const ListTile(
                title: Text("Privacy Policy"),
                trailing: Icon(Icons.open_in_new)),
          ],
        ),
      ),
    );
  }
}
