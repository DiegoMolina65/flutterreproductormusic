import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:reproductor/widgets/song_card.dart';

class SongList extends StatefulWidget {
  const SongList({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SongListState();
  }
}

class _SongListState extends State<SongList> {
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
      appBar: AppBar(
        title: const Row(
          children: [
            SizedBox(
              width: 55,
            ),
            Icon(Icons.music_note),
            Text(
              'Swift Music',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: songsResponse.isEmpty
            ? const CircularProgressIndicator()
            : ListView.builder(
                itemCount: songsResponse.length,
                itemBuilder: (context, index) {
                  return SongCard(
                    title: songsResponse[index]['title'],
                    albumCover: songsResponse[index]['album']['cover_big'],
                    artist: songsResponse[index]['artist']['name'],
                    duration: songsResponse[index]['duration'],
                    preview: songsResponse[index]['preview'],
                  );
                },
              ),
      ),
    );
  }
}
