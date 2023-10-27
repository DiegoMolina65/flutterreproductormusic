import 'package:flutter/material.dart';
import 'package:reproductor/artista.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Artista(),
    );
  }
}
