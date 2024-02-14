import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:game_portfolio/constants/animation_configs.dart';
import 'package:game_portfolio/constants/globals.dart';
import 'package:game_portfolio/games/super_mario_bros_game.dart';

class Hulk extends SpriteAnimationComponent
    with HasGameRef<SuperMarioBrosGame>, CollisionCallbacks {
  // final double _speed = 10;

  Hulk({
    required Vector2 position,
  }) : super(
          position: position,
          size: Vector2(
            Globals.tileSize * 2,
            Globals.tileSize * 2,
          ),
          anchor: Anchor.topCenter,
          animation: AnimationConfigs.heros.hulk(),
        ) {


    add(CircleHitbox());
  }
}
