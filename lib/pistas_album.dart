import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:reproductor/cancion_card.dart';

class AlbumTrackList extends StatefulWidget {
  const AlbumTrackList(
      {super.key, required this.albumId, required this.albumCover});

  final int albumId;
  final String albumCover;

  @override
  State<StatefulWidget> createState() {
    return _AlbumTrackListState();
  }
}

class _AlbumTrackListState extends State<AlbumTrackList> {
  var albumTrackResponse = [];

  Future<void> fetchAlbumTrackList() async {
    final response = await http.get(
        Uri.parse('https://api.deezer.com/album/${widget.albumId}/tracks'));

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      albumTrackResponse = data['data'];

      setState(() {
        albumTrackResponse;
      });
    } else {
      throw Exception('Failed to load album tracks.');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAlbumTrackList();
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
        child: albumTrackResponse.isEmpty
            ? const CircularProgressIndicator()
            : ListView.builder(
                itemCount: albumTrackResponse.length,
                itemBuilder: (context, index) {
                  return CancionCard(
                    title: albumTrackResponse[index]['title'],
                    albumCover: widget.albumCover,
                    artist: albumTrackResponse[index]['artist']['name'],
                    duration: albumTrackResponse[index]['duration'],
                    preview: albumTrackResponse[index]['preview'],
                  );
                },
              ),
      ),
    );
  }
}
