import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer? advancedPlayer;
  const AudioFile({super.key, this.advancedPlayer});

  @override
  State<AudioFile> createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration = new Duration();
  Duration _position = new Duration();
  final String path = "asset/audios/audio-1.mp3";
  bool isPlaying = false;
  bool isPaused = false;
  bool isLoop = false;
  bool isRepeat = false;
  List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled,
  ];

  @override
  void initState() {
    super.initState();
    this.widget.advancedPlayer!.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });
    this.widget.advancedPlayer!.onPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });
  }

  Widget btnStart() {
    return IconButton(
      padding: const EdgeInsets.only(bottom: 10),
      icon: isPlaying == false
          ? Icon(
              _icons[0],
              size: 50.0,
              color: Colors.blue,
            )
          : Icon(
              _icons[1],
              size: 50.0,
              color: Colors.blue,
            ),
      onPressed: () {
        if (isPlaying == false) {
          if (kDebugMode) print(">>>>>>> Audio Played");
          setState(() => isPlaying = true);
        } else if (isPlaying == true) {
          this.widget.advancedPlayer!.pause();
          setState(() {
            isPlaying = false;
          });
        }
      },
    );
  }

  Widget loadAsset() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          btnRepeat(),
          btnSlow(),
          btnStart(),
          btnFast(),
          btnLoop(),
        ],
      ),
    );
  }

  Widget slider() {
    return Slider(
        activeColor: Colors.red,
        inactiveColor: Colors.grey,
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            changeToSecond(value.toInt());
            value = value;
          });
        });
  }

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    this.widget.advancedPlayer!.seek(newDuration);
  }

  Widget btnFast() {
    return IconButton(
      icon: ImageIcon(
        AssetImage("asset/images/forward.png"),
        size: 15.0,
        color: Colors.black,
      ),
      onPressed: () {},
    );
  }

  Widget btnSlow() {
    return IconButton(
      icon: ImageIcon(
        AssetImage("asset/images/backward.png"),
        size: 15.0,
        color: Colors.black,
      ),
      onPressed: () {},
    );
  }

  Widget btnLoop() {
    return IconButton(
      icon: ImageIcon(
        AssetImage("asset/images/loap.png"),
        size: 15.0,
        color: Colors.black,
      ),
      onPressed: () {},
    );
  }

  Widget btnRepeat() {
    return IconButton(
      icon: ImageIcon(
        AssetImage("asset/images/repeat.png"),
        size: 15.0,
        color: Colors.black,
      ),
      onPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _position.toString().split(".")[0],
                  style: TextStyle(fontSize: 16.0),
                ),
                Text(
                  _duration.toString().split(".")[0],
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
          slider(),
          loadAsset(),
        ],
      ),
    );
  }
}
