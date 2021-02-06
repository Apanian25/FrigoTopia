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
      lightShinning = !lightShinning;
      _shineController.isActive = !_shineController?.isActive ?? false;
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

    // _fridgeOpen.isActiveChanged.addListener(() {
    //   if (!_fridgeOpen.isActive) {
    //     print("light-shine starting");
    //     setState(() {
    //       // lightShinning = true;
    //       // isOpen = true;
    //       if (_shineController == null) {
    //         _artboard = file.mainArtboard
    //           ..addController(_shineController = ShineAnimation('Shine'));
    //       }
    //     });
    //   }
    // });
  }

  void toggleOpen() {
    _togglePlay();
    print("Wtf");
    if (lightShinning) {
      _shineController.stop();
    } else {
      _shineController.start();
    }
    if (isOpen) {
      _artboard..addController(_fridgeClose = SimpleAnimation('Close'));
    } else {
      _artboard..addController(_fridgeOpen = SimpleAnimation('Open'));
    }
    // setState(() {
    //   isOpen = !isOpen;
    // });
    setState(() => isOpen = !isOpen);
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
      body: Center(
          child: _artboard == null
              ? const SizedBox()
              : GestureDetector(
                  onTap: toggleOpen,
                  child: Rive(artboard: _artboard),
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: _togglePlay,
        tooltip: isPlaying ? 'Pause' : 'Play',
        child: Icon(
          isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
