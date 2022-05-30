import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/src/audioplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MediaFile extends StatefulWidget {
  final AudioPlayer advPlayer;
  final AudioCache audioCache;
  //final String path;

  const MediaFile({Key? key, required this.advPlayer, required this.audioCache}) //, required this.path
      : super(key: key);

  @override
  State<MediaFile> createState() => _MediaFileState();
}

class _MediaFileState extends State<MediaFile> {
  Duration _duration = new Duration();
  Duration _position = new Duration();

  final String path =
      "https://thegrowingdeveloper.org/files/audios/quiet-time.mp3?b4869097e4";
  //"https://docs.google.com/uc?export=open&id=19yOcU9KYAtcNBoRbPDpv3DyVBtUv9bUS";
  //"https://thegrowingdeveloper.org/files/audios/quiet-time.mp3?b4869097e4";

  bool isPlaying = false;
  bool isPaused = false;
  bool isRepeat = false;
  bool isShuffling = false;
  Color repeatColor = Colors.white;
  Color shuffleColor = Colors.white;
  List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled,
  ];

  @override
  void initState() {
    super.initState();

    this.widget.advPlayer.onDurationChanged.listen((dur) {
      setState(() {
        _duration = dur;
      });
    });

    this.widget.advPlayer.onAudioPositionChanged.listen((pos) {
      setState(() {
        _position = pos;
      });
    });

    this.widget.advPlayer.setUrl(path); //this.widget.path
    this.widget.advPlayer.onPlayerCompletion.listen((event) {
      if (isRepeat == false) {
        setState(() {
          _position = Duration(seconds: 0);
          isPlaying = false;
        });
      }
    });
  }

  Widget btnStart() {
    return IconButton(
      padding: const EdgeInsets.only(bottom: 10),
      icon: isPlaying == false
          ? Icon(_icons[0], size: 50, color: Colors.blue)
          : Icon(_icons[1], size: 50, color: Colors.blue),
      onPressed: () async {
        if (isPlaying == false) {
          this.widget.advPlayer.play(path); //this.widget.path
          setState(() {
            isPlaying = true;
          });
        } else if (isPlaying == true) {
          this.widget.advPlayer.pause();
          setState(() {
            isPlaying = false;
          });
        }
      },
    );
  }

  Widget btnSkip() {
    return IconButton(
      icon: Icon(Icons.skip_next, size: 28, color: Colors.white),
      onPressed: () {},
    );
  }

  Widget btnPrev() {
    return IconButton(
      icon: Icon(Icons.skip_previous, size: 28, color: Colors.white),
      onPressed: () {},
    );
  }

  Widget btnRepeat() {
    return IconButton(
      icon: Icon(Icons.repeat, size: 25, color: repeatColor),
      onPressed: () {
        if (isRepeat == false) {
          this.widget.advPlayer.setReleaseMode(ReleaseMode.LOOP);
          setState(() {
            isRepeat = true;
            repeatColor = Colors.blue;
          });
        } else {
          this.widget.advPlayer.setReleaseMode(ReleaseMode.RELEASE);
          setState(() {
            isRepeat = false;
            repeatColor = Colors.white;
          });
        }
      },
    );
  }

  Widget btnShuffle() {
    return IconButton(
      icon: Icon(Icons.shuffle, size: 25, color: shuffleColor),
      onPressed: () {
        if (isShuffling == false) {
          //this.widget.advPlayer.setReleaseMode(ReleaseMode.LOOP);
          setState(() {
            isShuffling = true;
            shuffleColor = Colors.blue;
          });
        } else {
          //this.widget.advPlayer.setReleaseMode(ReleaseMode.RELEASE);
          setState(() {
            isShuffling = false;
            shuffleColor = Colors.white;
          });
        }
      },
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
    this.widget.advPlayer.seek(newDuration);
  }

  Widget loadAsset() {
    return Container(
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
          btnRepeat(),
          btnPrev(),
          btnStart(),
          btnSkip(),
          btnShuffle()
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(_position.toString().split(".")[0],
                style: TextStyle(fontSize: 16, color: Colors.white)),
            Text(_duration.toString().split(".")[0],
                style: TextStyle(fontSize: 16, color: Colors.white)),
          ]),
        ),
        slider(),
        loadAsset(),
      ],
    ));
  }
}
