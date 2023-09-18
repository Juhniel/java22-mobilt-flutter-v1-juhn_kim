import 'package:flutter/material.dart';

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

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // UI Interactive Widgets
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondPage()),
              );
            },
            child: const Text('Go to Second Page'),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Enter text',
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('TextButton'),
          ),

          // UI Layout Widgets
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Icon(Icons.star), Icon(Icons.star), Icon(Icons.star)],
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

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: Center(
        // UI Widget using local resource or URI from the web
        child: Image.network('https://hips.hearstapps.com/hmg-prod/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg?crop=0.752xw:1.00xh;0.175xw,0&resize=1200:*'),
      ),
    );
  }
}
