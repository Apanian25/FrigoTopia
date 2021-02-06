// home screen contents
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

import 'shine_animation.dart';

class Fridge extends StatefulWidget {
  @override
  _FridgeState createState() => new _FridgeState();
}

class _FridgeState extends State<Fridge> with SingleTickerProviderStateMixin {
  /// Tracks if the animation is playing by whether controller is running.
  bool isOpen = false;
  bool lightShinning = false;
  bool get isPlaying =>
      _fridgeOpen?.isActive ?? _fridgeClose?.isActive ?? false;
  final riveFileName = 'assets/images/frigomain.riv';
  void _togglePlay() {
    setState(() {
      if (_shineController != null) {
        _shineController.isActive = isOpen;
      }
    });
  }

  Artboard _artboard;
  RiveAnimationController _fridgeOpen;
  ShineAnimation _shineController;
  RiveAnimationController _fridgeClose;

  void _loadRiveFile() async {
    final bytes = await rootBundle.load(riveFileName);
    final file = RiveFile();
    lightShinning = false;
    isOpen = false;

    if (file.import(bytes)) {
      setState(() => _artboard = file.mainArtboard
        ..addController(_fridgeOpen = SimpleAnimation('Open')));
    }

    _fridgeOpen.isActiveChanged.addListener(() {
      if (!_fridgeOpen.isActive) {
        lightShinning = true;
        isOpen = true;
        if (_shineController == null) {
          SchedulerBinding.instance.addPostFrameCallback((d) {
            setState(() {
              _artboard = file.mainArtboard
                ..addController(_shineController = ShineAnimation('Shine'));
            });
          });
        }
      }
    });
  }

  void toggleOpen() {
    print(lightShinning);
    // if (lightShinning) {
    // } else {
    // }
    if (isOpen) {
      _artboard..addController(_fridgeClose = SimpleAnimation('Close'));
      _shineController.stop();
    } else {
      _artboard..addController(_fridgeOpen = SimpleAnimation('Open'));
      _shineController.start();
    }
    setState(() {
      isOpen = !isOpen;
      _togglePlay();
    });
    // SchedulerBinding.addPostFrameCallback(P)
  }

  @override
  void initState() {
    super.initState();
    _loadRiveFile();

    // Load the animation file from the bundle, note that you could also
    // download this. The RiveFile just expects a list of bytes.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff00DCA7),
        body: Stack(children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text.rich(
                TextSpan(
                  text: 'Hello', // default text style
                  children: <TextSpan>[
                    TextSpan(
                        text: ' beautiful ',
                        style: TextStyle(fontStyle: FontStyle.italic)),
                    TextSpan(
                        text: 'world',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              )),
          Transform.scale(
            alignment: Alignment.centerLeft,
            scale: 0.9,
            child: Align(
                alignment: Alignment.centerLeft,
                child: _artboard == null
                    ? const SizedBox()
                    : GestureDetector(
                        onDoubleTap: toggleOpen,
                        child: Rive(artboard: _artboard),
                      )),
          )
        ]));
  }
}
