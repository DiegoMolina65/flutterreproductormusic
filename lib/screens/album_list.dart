import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:reproductor/widgets/album_card.dart';

class AlbumList extends StatefulWidget {
  const AlbumList({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AlbumListState();
  }
}

class _AlbumListState extends State<AlbumList> {
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
      appBar: AppBar(
        title: const Row(
          children: [
            SizedBox(width: 55,),
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
        child: albumsResponse.isEmpty
            ? const CircularProgressIndicator()
            : ListView.builder(
                itemCount: albumsResponse.length,
                itemBuilder: (context, index) {
                  return AlbumCard(
                    albumData: albumsResponse[index],
                  );
                },
              ),
      ),
    );
  }
}
