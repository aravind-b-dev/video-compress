import 'dart:isolate';
import 'dart:ui';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class VideoPlay extends StatefulWidget {
  VideoPlay({this.video});
  var video;

  @override
  _VideoPlayState createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  int progress = 0;
  late BetterPlayerController _betterPlayerController;
  late BetterPlayerDataSource _betterPlayerDataSource;


  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration =
    const BetterPlayerConfiguration(
        aspectRatio: 9/18,
        fit: BoxFit.contain,
        autoPlay: false,
        controlsConfiguration :BetterPlayerControlsConfiguration(
          showControls: true,
          enableSkips: false,
          enableFullscreen: true,
          // enableMute : false,
          // enableProgressText: false,
          // enableProgressBar :false,
          enablePip:false,
          enablePlayPause:false,
          enableOverflowMenu: false,
        )
    );



    _betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.file,
        widget.video
    );
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(_betterPlayerDataSource);
    super.initState();
  }

  @override
  dispose(){
    _betterPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding : const EdgeInsets.symmetric(horizontal: 10),
          height: MediaQuery.of(context).size.height*.25,
          width: MediaQuery.of(context).size.width,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            child: BetterPlayerMultipleGestureDetector(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: BetterPlayer(
                  controller: _betterPlayerController,
                ),
              ),
            ),
          ),
    );
  }
}