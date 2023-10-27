import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:reproductor/cancion_card.dart';

class ListaCancion extends StatefulWidget {
  const ListaCancion({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SongListState();
  }
}

class _SongListState extends State<ListaCancion> {
  var songsResponse = [];

  Future<void> fetchSongList() async {
    final response = await http
        .get(Uri.parse('https://api.deezer.com/artist/10583405/top?limit=50'));

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      songsResponse = data['data'];

      setState(() {
        songsResponse;
      });
    } else {
      throw Exception('Failed to load songs.');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSongList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1DB954),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: songsResponse.isEmpty
            ? const CircularProgressIndicator()
            : Container(
                child: ListView.builder(
                  itemCount: songsResponse.length,
                  itemBuilder: (context, index) {
                    return CancionCard(
                      title: songsResponse[index]['title'],
                      albumCover: songsResponse[index]['album']['cover_big'],
                      artist: songsResponse[index]['artist']['name'],
                      duration: songsResponse[index]['duration'],
                      preview: songsResponse[index]['preview'],
                    );
                  },
                ),
              ),
      ),
    );
  }
}
