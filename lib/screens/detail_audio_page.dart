import 'package:amg_e_book/constants/audio_file.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:amg_e_book/constants/app_colors.dart' as AppColors;
import 'package:get/get.dart';

class DetailAudioPage extends StatefulWidget {
  final booksData;
  final int index;
  const DetailAudioPage({super.key, this.booksData, required this.index});

  @override
  State<DetailAudioPage> createState() => _DetailAudioPageState();
}

class _DetailAudioPageState extends State<DetailAudioPage> {
  AudioPlayer? advancedPlayer;
  @override
  void initState() {
    super.initState();
    advancedPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppColors.audioBluishBackground,
        body: Stack(
          children: [
            Positioned(
                top: 0.0,
                left: 0.0,
                right: 0.0,
                height: screenHeight / 3,
                child: Container(
                  color: Colors.blue,
                )),
            Positioned(
                top: 0.0,
                left: 0.0,
                right: 0.0,
                child: AppBar(
                  leading: IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(Icons.arrow_back_ios)),
                  actions: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                  ],
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                )),
            Positioned(
                top: screenHeight * .2,
                left: .0,
                right: .0,
                height: screenHeight * .36,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                      color: Colors.white),
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight * .1,
                      ),
                      Text(this.widget.booksData[this.widget.index]["title"],
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Avenir",
                          )),
                      Text(
                        this.widget.booksData[this.widget.index]["text"],
                        style: TextStyle(fontSize: 20.0),
                      ),
                      AudioFile(
                        advancedPlayer: advancedPlayer,
                      ),
                    ],
                  ),
                )),
            Positioned(
                top: screenHeight * .12,
                left: (screenWidth - 150) / 2,
                right: (screenWidth - 150) / 2,
                height: screenHeight * .16,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.audioGreyBackground,
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Colors.white, width: 2.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 5.0),
                          image: DecorationImage(
                              image: AssetImage(this
                                  .widget
                                  .booksData[this.widget.index]["img"]),
                              fit: BoxFit.cover)),
                    ),
                  ),
                )),
          ],
        ));
  }
}
