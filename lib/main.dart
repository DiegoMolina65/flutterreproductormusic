import 'package:flutter/material.dart';
import 'package:reproductor/artista.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 10, 1, 29),
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData().copyWith(
          colorScheme: kColorScheme,
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
          )),
      home: const Artista(),
    );
  }
}
