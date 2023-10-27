import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reproductor/screens/album_list.dart';
import 'package:reproductor/screens/song_list.dart';
import 'dart:convert' as convert;
import 'package:reproductor/widgets/artist_card.dart';

class Artist extends StatefulWidget {
  const Artist({super.key});

  @override
  State<StatefulWidget> createState() => _ArtistState();
}

class _ArtistState extends State<Artist> {
  var artistResponse = {};

  // Definición de los colores de degradado
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
        title: const Text('Swift Music', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: artistResponse.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  ArtistCard(
                    name: artistResponse['name'],
                    imageUrl: artistResponse['picture_xl'],
                    fans: artistResponse['nb_fan'],
                    releases: artistResponse['nb_album'],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _goToAlbumsButton(),
                  _goToSongsButton(),
                ],
              ),
            ),
    );
  }

  Widget _goToSongsButton() {
    return Container(
      width: 250,
      height: 60,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_startGradientColor, _endGradientColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.play_arrow_outlined),
        label: Text('Canciones más populares', style: TextStyle(fontSize: 18)),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SongList()));
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
          onPrimary: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.all(0),
        ),
      ),
    );
  }

  Widget _goToAlbumsButton() {
    return Container(
      width: 250,
      height: 60,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_startGradientColor, _endGradientColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.play_arrow_outlined),
        label: Text('Ir a los álbumes', style: TextStyle(fontSize: 18)),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AlbumList()));
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
          onPrimary: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.all(0),
        ),
      ),
    );
  }
}
