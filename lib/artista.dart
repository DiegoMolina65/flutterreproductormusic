import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reproductor/lista_album.dart';
import 'package:reproductor/cancion_lista.dart';
import 'dart:convert' as convert;
import 'package:reproductor/artista_card.dart';

class Artista extends StatefulWidget {
  const Artista({super.key});

  @override
  State<StatefulWidget> createState() => _ArtistState();
}

class _ArtistState extends State<Artista> {
  var artistResponse = {};

  final Color _startGradientColor = Color(0xFF1ED760);
  final Color _endGradientColor = Color(0xFF1DB954);

  Future<void> fetchArtist() async {
    final response =
        await http.get(Uri.parse('https://api.deezer.com/artist/10583405'));

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      artistResponse = data;
      setState(() {});
    } else {
      throw Exception('Error al cargar el artista.');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchArtist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'SpotifyDieguin',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFA8FF78),
                Color(0xFF1DB954),
              ],
            ),
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: artistResponse.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  CardArtista(
                    name: artistResponse['name'],
                    imageUrl: artistResponse['picture_xl'],
                    fans: artistResponse['nb_fan'],
                    releases: artistResponse['nb_album'],
                  ),
                ],
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow_outlined, color: _startGradientColor),
            label: 'Canciones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.album, color: _startGradientColor),
            label: 'Albumes',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ListaCancion()));
          } else if (index == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ListaAlbum()));
          }
        },
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }
}
