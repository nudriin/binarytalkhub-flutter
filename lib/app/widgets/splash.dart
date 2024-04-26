import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class BackgroundVideo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BackgroundVideoState();
}

class _BackgroundVideoState extends State<BackgroundVideo> {
  late VideoPlayerController _controller;
  bool _visible = false;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    _controller = VideoPlayerController.asset("assets/326.mp4");
    _controller.initialize().then((_) {
      _controller.setLooping(true);
      Timer(Duration(milliseconds: 100), () {
        setState(() {
          _controller.play();
          _visible = true;
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _getVideoBackground() {
    return AnimatedOpacity(
        opacity: _visible ? 0.2 : 0.0,
        duration: Duration(milliseconds: 1000),
        child: SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _controller.value.size.width,
              height: _controller.value.size.height,
              child: VideoPlayer(_controller),
            ),
          ),
        ));
  }

  _getBackgroundColor() {
    return Container(
      color: Color.fromRGBO(15, 23, 42, 1),
    );
  }

  _getContent() {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 10), // Menambahkan margin simetris
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Top AI Platform',
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontSize: 13,
                ),
                textAlign: TextAlign.center),
            SizedBox(height: 15),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText('PDF ke GPT Summarizer',
                    textStyle: TextStyle(
                        fontSize: 25,
                        color: Color(0xFF7E30E1),
                        fontFamily: 'Futura'),
                    textAlign: TextAlign.center,
                    cursor: '|',
                    speed: Duration(milliseconds: 80)),
              ],
            ),
            Text(
              'Tranformasi Cepat dan Efisien',
              style: TextStyle(
                  fontSize: 25,
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'Futura'),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            Text(
              'Chat with the smartest AI - Experience the power of AI',
              style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1), fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          fit: StackFit.expand, // Memastikan Stack mengisi seluruh layar
          children: <Widget>[
            _getBackgroundColor(),
            _getVideoBackground(),
            _getContent()
          ],
        ),
      ),
    );
  }
}
