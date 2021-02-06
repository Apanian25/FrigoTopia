// home screen contents
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class Fridge extends StatefulWidget {
  @override
  _FridgeState createState() => new _FridgeState();
}

class _FridgeState extends State<Fridge> with SingleTickerProviderStateMixin {
  void _togglePlay() {
    setState(() =>
        _lightShineController.isActive = !_lightShineController?.isActive);
  }

  /// Tracks if the animation is playing by whether controller is running.

  bool lightShinning = true;
  bool get isPlaying => _fridgeOpen?.isActive ?? false;
  final riveFileName = 'assets/images/frigomain.riv';

  Artboard _artboard;
  RiveAnimationController _fridgeOpen;
  RiveAnimationController _lightShineController;

  void _loadRiveFile() async {
    final bytes = await rootBundle.load(riveFileName);
    final file = RiveFile();

    if (file.import(bytes)) {
      setState(() => _artboard = file.mainArtboard
        ..addController(_fridgeOpen = SimpleAnimation('door-open')));
    }

    _fridgeOpen.isActiveChanged.addListener(() {
      if (!_fridgeOpen.isActive) {
        print("light-shine starting");
        setState(() => _artboard = file.mainArtboard
          ..addController(
              _lightShineController = SimpleAnimation('light-shine')));
      }
    });
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
        child: _artboard == null ? const SizedBox() : Rive(artboard: _artboard),
      ),
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
