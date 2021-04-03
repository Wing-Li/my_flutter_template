import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:my_flutter_template/utils/my_utils.dart';
import 'package:my_flutter_template/view/my_app_bar.dart';
import 'package:my_flutter_template/view/my_network_image_widget.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class MyVideoPage extends StatefulWidget {
  final File video;
  final String videoUrl;
  final String thumbUrl;
  final bool isPrivate;

  /// 是否静音
  final bool isMute;

  const MyVideoPage({
    Key key,
    this.video,
    this.videoUrl,
    this.thumbUrl,
    this.isPrivate = false,
    this.isMute = false,
  }) : super(key: key);

  @override
  _MyVideoPageState createState() => _MyVideoPageState();
}

class _MyVideoPageState extends State<MyVideoPage> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.video != null) {
      _controller = VideoPlayerController.file(widget.video);
    } else if (!MyUtils.isEmpty(widget.videoUrl)) {
      _controller = VideoPlayerController.network(widget.videoUrl);
    }

    if (widget.isMute) _controller.setVolume(0);

    _controller
      ..setLooping(true)
      ..initialize().then((_) {
        setState(() {});
      })
      ..play();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MyUtils.isEmpty(widget.thumbUrl)
              ? SizedBox() //
              : MyNetworkImage(widget.thumbUrl, width: double.infinity, fit: BoxFit.fitWidth),
          Center(
            child: _controller.value.initialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(),
          ),
          MyAppBar(
            leftWidget: Icon(Icons.close, color: Colors.white, size: 36),
            onLeftTap: () => MyUtils.popPage(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying ? _controller.pause() : _controller.play();
          });
        },
        backgroundColor: Colors.black45,
        child: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
}
