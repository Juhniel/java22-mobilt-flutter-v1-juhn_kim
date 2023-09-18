import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedText();
  }
  // Async function to load saved text from shared preferences into text field.
  _loadSavedText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _textEditingController.text = (prefs.getString('saved_text') ?? "");
    });
  }
  // Async function to save text into shared preferences for persistence.
  _saveText(String text) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('saved_text', text);
  }

  // Build method for UI components.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Elevated button to navigate to the second page.
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondPage()),
              );
            },
            child: const Text('Go to Second Page'),
          ),
          // Text field for data entry, which gets saved for later.
          TextFormField(
            controller: _textEditingController,
            decoration: const InputDecoration(
              labelText: 'Enter text',
            ),
            onChanged: (text) {
              _saveText(text);
            },
          ),
          // Text button with no functionality for now.
          TextButton(
            onPressed: () {},
            child: const Text('TextButton'),
          ),

          // Row containing icons.
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Icon(Icons.handshake), Icon(Icons.sailing), Icon(Icons.star)],
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Padding Widget'),
          ),
          const Center(
            child: Text('Center Widget'),
          ),
        ],
      ),
    );
  }
}

// SecondPage contains a dynamic image fetched from an API.
class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  _SecondPageState createState() => _SecondPageState();
}

// _SecondPageState handles the state for SecondPage.
class _SecondPageState extends State<SecondPage> {
  String imageUrl = "";

  @override
  void initState() {
    super.initState();
    fetchDogImage();  // Fetch a dog image URL as soon as the page is loaded.
  }

  // Async function to fetch random dog image URL from API.
  fetchDogImage() async {
    final response = await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        imageUrl = data['message'];
      });
    }
  }

  // Build method for UI components.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: Center(
        child: imageUrl == ""
            ? const CircularProgressIndicator()
            : Image.network(imageUrl),
      ),
    );
  }
}

