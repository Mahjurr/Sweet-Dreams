import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../views/dreams_view.dart';
import '../presenter/dreams_presenter.dart';
import '../utils/app_colors.dart' as AppColors;
import 'media_file.dart';

class MediaPage extends StatefulWidget {
  final MEDIAPresenter presenter;

  MediaPage(this.presenter, {required Key? key, required this.title})
      : super(key: key);
  final String title;

  @override
  _MediaPageState createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> implements MEDIAView {
  //var _formKey = GlobalKey<FormState>();
  late AudioPlayer advPlayer;
  late AudioCache audioCache;
  //late String path = "";
  //late String songName = "";
  //late String artist = "";
  List _items = [];

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString("lib/assests/songs.json");
    final data = await json.decode(response);
    setState(() {
      _items = data["items"];
    });
  }

  @override
  void initState() {
    super.initState();
    this.readJson();

    //path = _items[1]["audio"];
    //songName = _items[1]["name"];
    //artist = _items[1]["artist"];

    advPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advPlayer);
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: screenHeight / 3,
              child: Container(color: AppColors.lightAccent)),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop()),
                actions: [
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      readJson();
                    },
                  )
                ]),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: screenHeight * .2,
            height: screenHeight * .36,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: AppColors.textField,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * .1,
                    ),
                    Text("test", //songName,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: "Avenir")),
                    Text("tset", //artist,
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                    MediaFile(
                      advPlayer: advPlayer,
                      audioCache: audioCache,
                      //path: path,
                    ),
                  ],
                )),
          ),
          Positioned(
            top: screenHeight * .12,
            left: (screenWidth - 125) / 2,
            right: (screenWidth - 125) / 2,
            height: screenHeight * .16,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.darkBackground,
                ),
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.darkBackground,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image:
                                  AssetImage('lib/assests/images/256DreamIcon.png'),
                              fit: BoxFit.cover)
                      ),
                    ))),
          ),
          Positioned(
              top: screenHeight * .6,
              left: 10,
              right: 10,
              height: screenHeight * .39,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 0),
                itemCount: _items.length,
                //itemExtent: 50,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Material(
                      child: ListTile(
                        //leading: Text(_items[index]["id"]),
                        title: Text(_items[index]["name"]),
                        subtitle: Text(_items[index]["owner"]),
                        onTap: () {
                          //advPlayer.release();
                          /*
                          setState(() {
                            path = _items[index]["audio"];
                          });
                          setState(() {
                            songName = _items[index]["name"];
                          });
                          setState(() {
                            artist = _items[index]["owner"];
                          });
                          */
                          advPlayer.setUrl(_items[index]["audio"]);
                          advPlayer.play(_items[index]["audio"]);
                        },
                      ),
                    ),
                  );
                },
              ))
        ],
      ),
    );
  }
}
