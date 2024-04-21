import 'package:flutter/material.dart';

void main() => runApp(GuiComponentsApp());

class GuiComponentsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GUI Components App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.dark,
      ),
      home: GuiComponentsPage(),
    );
  }
}

class GuiComponentsPage extends StatefulWidget {
  @override
  _GuiComponentsPageState createState() => _GuiComponentsPageState();
}

class _GuiComponentsPageState extends State<GuiComponentsPage> {
  final TextEditingController _itemController = TextEditingController();
  List<String> _items = [];
  bool _showFab = true;

  void _addItem() {
    final String item = _itemController.text;
    if (item.isNotEmpty) {
      setState(() {
        _items.add(item);
        _itemController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GUI Components App'),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'GUI Components App',
                applicationVersion: '1.0.0',
                applicationLegalese: 'Copyright © 2024 Jess John',
              );
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top:40.0),
            child: Text(
                '32 Jess John TE_COMPS',
                style: TextStyle(
                  color: Colors.deepPurpleAccent,
                  fontSize: 16.0,
                ),
              ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _itemController,
              decoration: InputDecoration(
                labelText: 'Enter an item',
                labelStyle: TextStyle(color: Colors.deepPurpleAccent),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurpleAccent),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _addItem,
            child: Text('Add Item'),
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurpleAccent,
              onPrimary: Colors.white,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.deepPurple.shade700,
                    child: ListTile(
                      title: Text(
                        _items[index],
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () {
                          setState(() {
                            _items.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _showFab
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  _showFab = false;
                });
              },
              child: Icon(Icons.delete_forever),
              backgroundColor: Colors.deepPurpleAccent,
            )
          : null,
    );
  }
}