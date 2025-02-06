import 'package:flutter/material.dart';
import 'package:modern_profile/screen/editprofile_screen.dart';

class EditOshiPage extends StatefulWidget {
  final List<String> selectedOshi;
  final List<String> oshiNames;

  EditOshiPage(
      {required this.selectedOshi,
      required this.oshiNames,
      required List<String> oshiPaths});

  @override
  _EditOshiPageState createState() => _EditOshiPageState();
}

class _EditOshiPageState extends State<EditOshiPage> {
  late List<String> _tempSelectedOshi;

  @override
  void initState() {
    super.initState();
    _tempSelectedOshi = List.from(widget.selectedOshi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit My Oshi'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.oshiNames.length,
              itemBuilder: (context, index) {
                final name = widget.oshiNames[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/icons/icon${index + 1}.png'),
                  ),
                  title: Text(name),
                  trailing: Checkbox(
                    value: _tempSelectedOshi.contains(name),
                    onChanged: (selected) {
                      setState(() {
                        if (selected == true) {
                          _tempSelectedOshi.add(name);
                        } else {
                          _tempSelectedOshi.remove(name);
                        }
                      });
                    },
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, _tempSelectedOshi);
            },
            child: Text('Confirm'),
          )
        ],
      ),
    );
  }
}
