import 'package:flutter/material.dart';
import 'package:reproductor/musica_btn.dart';

class CancionCard extends StatelessWidget {
  const CancionCard({
    super.key,
    required this.duration,
    required this.title,
    required this.albumCover,
    required this.preview,
    required this.artist,
  });

  final int duration;
  final String title;
  final String albumCover;
  final String preview;
  final String artist;

  @override
  Widget build(BuildContext context) {
    String formatDuration(int seconds) {
      int minutes = seconds ~/ 60;
      int remainingSeconds = seconds % 60;

      return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      color: Colors.black, // Fondo negro
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image(
                image: NetworkImage(albumCover),
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(height: 8),
            Text(
              artist,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatDuration(duration),
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                MusicaBtn(
                  preview,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
