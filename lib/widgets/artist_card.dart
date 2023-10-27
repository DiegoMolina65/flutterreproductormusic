import 'package:flutter/material.dart';

class ArtistCard extends StatelessWidget {
  const ArtistCard({
    required this.name,
    required this.imageUrl,
    required this.releases,
    required this.fans,
    Key? key,
  }) : super(key: key);

  final String name;
  final String imageUrl;
  final int releases;
  final int fans;

  @override
  Widget build(BuildContext context) {
    String formatToMillion(int number) {
      double inMillions = number / 1000000.0;
      return "${inMillions.toStringAsFixed(2)}M";
    }

    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.purple, Colors.blue],
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image(
                  image: NetworkImage(imageUrl),
                  width: double.infinity,
                  height: 310,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                name,
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade900,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Releases: $releases",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey.shade900,
                    ),
                  ),
                  Text(
                    "Fans: ${formatToMillion(fans)}",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey.shade900,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
