import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:reproductor/album_card.dart';

class ListaAlbum extends StatefulWidget {
  const ListaAlbum({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AlbumListState();
  }
}

class _AlbumListState extends State<ListaAlbum> {
  var albumsResponse = [];

  Future<void> fetchAlbumList() async {
    final response = await http
        .get(Uri.parse('https://api.deezer.com/artist/10583405/albums'));

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      albumsResponse = data['data'];

      setState(() {
        albumsResponse;
      });
    } else {
      throw Exception('Failed to load Albums.');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAlbumList();
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
        child: albumsResponse.isEmpty
            ? const CircularProgressIndicator()
            : ListView.builder(
                itemCount: albumsResponse.length,
                itemBuilder: (context, index) {
                  return CardAlbum(
                    albumData: albumsResponse[index],
                  );
                },
              ),
      ),
    );
  }
}
