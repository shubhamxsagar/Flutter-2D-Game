import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/services.dart';
import 'package:game_portfolio/constants/animation_configs.dart';
import 'package:game_portfolio/constants/globals.dart';
import 'package:game_portfolio/objects/platform.dart';

enum MarioAnimationState {
  idle,
  walking,
  jumping,
}

class Mario extends SpriteAnimationGroupComponent<MarioAnimationState>
    with CollisionCallbacks, KeyboardHandler {
  final double _gravity = 15;
  final Vector2 velocity = Vector2.zero();

  final Vector2 _up = Vector2(0, -1);
  bool _jumpInput = false;
  bool isOnGround = false;

  // PositionComponent? _currentPlatform;

  static const double _minMoveSpeed = 125;
  static const double _maxMoveSpeed = _minMoveSpeed + 100;

  double _currentSpeed = _minMoveSpeed;
  bool isFacingRight = true;

  int _hAxisInput = 0;

  late Vector2 _minClamp;
  late Vector2 _maxClamp;

  final double _jumpSpeed = 300;

  Mario({required Vector2 position, required Rectangle levelBounds})
      : super(
          position: position,
          size: Vector2(
            Globals.tileSize * 2,
            Globals.tileSize * 2,
          ),
          anchor: Anchor.topLeft,
        ) {
    // debugMode = true;
    _minClamp = levelBounds.topLeft + (size / 2);
    _maxClamp = levelBounds.bottomRight + (size / 2);
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (dt > 0.05) return;
    velocityUpdate();
    positionUpdate(dt);
    speedUpdate();
    facingDirection();
    jumpUpdate();
    marioAnimationUpdate();
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    _hAxisInput = 0;
    _hAxisInput += keysPressed.contains(LogicalKeyboardKey.arrowLeft) ? -1 : 0;
    _hAxisInput += keysPressed.contains(LogicalKeyboardKey.arrowRight) ? 1 : 0;
    _jumpInput = keysPressed.contains(LogicalKeyboardKey.arrowUp);
    return super.onKeyEvent(event, keysPressed);
  }

  void jumpUpdate() {
    if (_jumpInput && isOnGround) {
      jump();
    }
  }

  void jump() {
    velocity.y -= _jumpSpeed;
    isOnGround = false;
    // AnimationConfigs.mario.idle();

    FlameAudio.play(Globals.jumpSmallSFX);
  }

  void speedUpdate() {
    if (_hAxisInput == 0) {
      _currentSpeed = _minMoveSpeed;
    } else {
      if (_currentSpeed <= _maxMoveSpeed) {
        _currentSpeed++;
      }
    }
  }

  void facingDirection() {
    if (_hAxisInput > 0) {
      isFacingRight = true;
    } else {
      isFacingRight = false;
    }

    if ((_hAxisInput < 0 && scale.x > 0) || (_hAxisInput > 0 && scale.x < 0)) {
      flipHorizontallyAroundCenter();
    }
  }

  void velocityUpdate() {
    velocity.y += _gravity;
    velocity.y = velocity.y.clamp(-_jumpSpeed, 150);
    velocity.x = _hAxisInput * _currentSpeed;
    // position += velocity;
  }

  void marioAnimationUpdate() {
    if (!isOnGround) {
      current = MarioAnimationState.jumping;
    } else if (_hAxisInput < 0 || _hAxisInput > 0) {
      current = MarioAnimationState.walking;
    } else if (_hAxisInput == 0) {
      current = MarioAnimationState.idle;
    }
  }

  void positionUpdate(double dt) {
    Vector2 distance = velocity * dt;
    position += distance;
    position.clamp(_minClamp, _maxClamp);
  }

  @override
  Future<void>? onLoad() async {
    final SpriteAnimation idle = await AnimationConfigs.mario.idle();
    final SpriteAnimation walking = await AnimationConfigs.mario.walking();
    final SpriteAnimation jumping = await AnimationConfigs.mario.jumping();
    animations = {
      MarioAnimationState.idle: idle,
      MarioAnimationState.walking: walking,
      MarioAnimationState.jumping: jumping,
    };
    current = MarioAnimationState.idle;
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Platform) {
      if (intersectionPoints.length == 2) {
        platformPositionCheck(intersectionPoints);
      }
    }
  }

  void platformPositionCheck(Set<Vector2> intersectionPoints) {
    final Vector2 mid =
        (intersectionPoints.elementAt(0) + intersectionPoints.elementAt(1)) / 2;
    final Vector2 collisionNormal = absoluteCenter - mid;
    double penetrationLength = (size.x / 2) - collisionNormal.length;
    collisionNormal.normalize();
    if (_up.dot(collisionNormal) > -0.9) {
      isOnGround = true;
    }
    position += collisionNormal.scaled(penetrationLength);
  }
}
