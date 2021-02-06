import 'package:rive/rive.dart';

class ShineAnimation extends SimpleAnimation {
  ShineAnimation(String animationName) : super(animationName);

  start() {
    instance.animation.loop = Loop.loop;
    isActive = true;
  }

  stop() => instance.animation.loop = Loop.oneShot;
}
