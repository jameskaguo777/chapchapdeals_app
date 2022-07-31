import 'package:flutter/material.dart';

class InitialsIndex extends StatefulWidget {
  const InitialsIndex({Key? key}) : super(key: key);

  @override
  State<InitialsIndex> createState() => _InitialsIndexState();
}

class _InitialsIndexState extends State<InitialsIndex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 63, 222, 68),
      body: Center(
        child: Text('Initials'),
      ),
    );
  }
}