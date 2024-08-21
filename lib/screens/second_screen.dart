import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {

  final String data;

  const SecondScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Screen",style: TextStyle(color: Colors.white70),),
        backgroundColor: Colors.deepPurple,
      ),
      body: Text(data),
    );
  }
}
