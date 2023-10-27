import 'package:flutter/material.dart';
import 'package:reproductor/widgets/music_button.dart';

class SongCard extends StatelessWidget {
  const SongCard({
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
                  image: NetworkImage(albumCover),
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
                      title,
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
                      artist,
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
                          formatDuration(duration),
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
              MusicButton(preview),
            ],
          ),
        ),
      ),
    );
  }
}
