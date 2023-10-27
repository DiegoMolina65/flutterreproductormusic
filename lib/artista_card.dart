import 'package:flutter/material.dart';

class CardArtista extends StatelessWidget {
  const CardArtista({
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
      height: 400, 
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.black, Colors.grey.shade900],
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
              child: Image(
                image: NetworkImage(imageUrl),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              color: Colors.black,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Álbumes: $releases",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      Text(
                        "Seguidores: ${formatToMillion(fans)}",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
