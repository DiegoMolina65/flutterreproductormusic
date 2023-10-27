import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reproductor/screens/album_tracks.dart';

class AlbumCard extends StatelessWidget {
  const AlbumCard({
    super.key,
    required this.albumData,
  });

  final albumData;

  String formatDateToYear(String date) {
    return date.split('-')[0];
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AlbumTrackList(
              albumId: albumData['id'],
              albumCover: albumData['cover_big'],
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 197, 215, 254),
                Color.fromARGB(255, 233, 235, 255),
              ],
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image(
                    image: NetworkImage(albumData['cover_big']),
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        albumData['title'],
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade900,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        formatDateToYear(albumData['release_date']),
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey.shade900,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${NumberFormat('#,###').format(albumData['fans'])} fans",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey.shade700,
                              fontStyle: FontStyle.italic,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
