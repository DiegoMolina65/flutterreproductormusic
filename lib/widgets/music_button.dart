import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicButton extends StatefulWidget {
  const MusicButton(this.preview, {super.key});

  final String preview;

  @override
  State<StatefulWidget> createState() {
    return _MusicButtonState();
  }
}

class _MusicButtonState extends State<MusicButton> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.completed) {
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _togglePlay() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(UrlSource(widget.preview));
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(_isPlaying
          ? Icons.pause_circle_filled
          : Icons
              .play_circle_filled),
      color: Colors.indigo,
      iconSize: 60.0,
      onPressed: _togglePlay,
    );
  }
}
