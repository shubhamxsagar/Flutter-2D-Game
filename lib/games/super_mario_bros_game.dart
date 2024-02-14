import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:game_portfolio/constants/globals.dart';
import 'package:game_portfolio/levels/level.dart';
import 'package:game_portfolio/levels/level_option.dart';

class SuperMarioBrosGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents {
  late CameraComponent cameraComponent;
  late final TiledComponent map;
  late final double scaleSize;
  LevelComponent? _currentLevel;
  @override
  final World world = World();
  @override
  Future<void> onLoad() async {
    cameraComponent = CameraComponent(world: world);
    map = await TiledComponent.load(
      Globals.lv_1_1,
      Vector2.all(Globals.tileSize),
      // Vector2.all(8),
    );
    world.add(map);
    scaleSize = size.y / map.size.y;

    // cameraComponent.viewfinder
    //   ..zoom = scaleSize
    //   ..anchor = Anchor.topLeft;
    cameraComponent
      ..viewport.size = Vector2(450, 50)
      ..viewport.position = Vector2(500, 0)
      ..viewfinder.visibleGameSize = Vector2(450, 50)
      ..viewfinder.position = Vector2(0, 0)
      ..viewfinder.anchor = Anchor.topLeft;

    await addAll([world, cameraComponent]);
    loadLevel(LevelOption.lv_1_1);
    return super.onLoad();
  }

  void loadLevel(LevelOption level) {
    _currentLevel?.removeFromParent();
    _currentLevel = LevelComponent(level);
    add(_currentLevel!);
  }
}
