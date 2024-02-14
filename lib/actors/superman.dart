import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:game_portfolio/constants/animation_configs.dart';
import 'package:game_portfolio/constants/globals.dart';
import 'package:game_portfolio/games/super_mario_bros_game.dart';

class Superman extends SpriteAnimationComponent
    with HasGameRef<SuperMarioBrosGame>, CollisionCallbacks {
  // final double _speed = 10;

  Superman({
    required Vector2 position,
  }) : super(
          position: position,
          size: Vector2(
            Globals.tileSize * 2,
            Globals.tileSize * 2,
          ),
          anchor: Anchor.topCenter,
          animation: AnimationConfigs.heros.superman(),
        ) {
    // Vector2 targetPosition = position;

    // Goomba will move 100 pixels to the left and right.
    // targetPosition.x -= 100;

    // final SequenceEffect effect = SequenceEffect(
    //   [
    //     MoveToEffect(
    //       targetPosition,
    //       EffectController(speed: _speed),
    //     ),
    //     MoveToEffect(
    //       position,
    //       EffectController(speed: _speed),
    //     ),
    //   ],
    //   infinite: true,
    //   alternate: true,
    // );

    // add(effect);

    add(CircleHitbox());
  }

  // @override
  // void onCollision(
  //     Set<Vector2> intersectionPoints, PositionComponent other) async {
  //   if (other is Mario) {
  //     if (!other.isOnGround) {
  //       other.jump();

  //       animation = AnimationConfigs.goomba.dead();

  //       position.y += 0.5;

  //       // Display defeated Goomba for 0.5 seconds.
  //       await Future.delayed(
  //         const Duration(
  //           milliseconds: 500,
  //         ),
  //       );

  //       // Remove dead Goomba.
  //       removeFromParent();
  //     }
  //   }

  //   super.onCollision(intersectionPoints, other);
  // }
}
