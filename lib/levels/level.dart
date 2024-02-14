import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:game_portfolio/actors/captain.dart';
import 'package:game_portfolio/actors/doraemon.dart';
import 'package:game_portfolio/actors/goomba.dart';
import 'package:game_portfolio/actors/hulk.dart';
import 'package:game_portfolio/actors/mario.dart';
import 'package:game_portfolio/actors/spiderman.dart';
import 'package:game_portfolio/actors/superman.dart';
import 'package:game_portfolio/actors/thor.dart';
import 'package:game_portfolio/constants/globals.dart';
import 'package:game_portfolio/games/super_mario_bros_game.dart';
import 'package:game_portfolio/levels/level_option.dart';
import 'package:game_portfolio/objects/brick_block.dart';
import 'package:game_portfolio/objects/platform.dart';

class LevelComponent extends Component with HasGameRef<SuperMarioBrosGame> {
  late final LevelOption option;
  late Rectangle _levelBounds;

  late CameraComponent cameraComponent;
  late final TiledComponent level;
  late final double scaleSize;
  late Mario _mario;

  LevelComponent(this.option) : super();

  @override
  Future<void> onLoad() async {
    // cameraComponent = CameraComponent(world: world);
    level = await TiledComponent.load(
      Globals.lv_1_1,
      Vector2.all(Globals.tileSize),
      // Vector2.all(8),
    );
    gameRef.world.add(level);
    _levelBounds = Rectangle.fromPoints(
      Vector2(0, 0),
      Vector2(level.tileMap.map.width.toDouble(),
              level.tileMap.map.height.toDouble()) *
          Globals.tileSize,
    );
    // createBlocks(level.tileMap);
    createActors(level.tileMap);
    createPlatform(level.tileMap);

    _setUpCamera();

    return super.onLoad();
  }

  void createActors(RenderableTiledMap tileMap) {
    ObjectGroup? actorsLayer = tileMap.getLayer<ObjectGroup>("Actors");
    if (actorsLayer == null) {
      throw Exception("No actor layer found");
    }
    for (final TiledObject obj in actorsLayer.objects) {
      // Platform platform = Platform(
      //     position: Vector2(obj.x, obj.y),
      //     size: Vector2(obj.width, obj.height));
      // gameRef.world.add(platform);
      switch (obj.name) {
        case 'Mario':
          _mario = Mario(
            position: Vector2(obj.x, obj.y),
            levelBounds: _levelBounds,
          );
          // case 'Mystery':
          //   final MysteryBlock mysteryBlock = MysteryBlock(
          //     position: Vector2(obj.x, obj.y),
          //   );
          //   gameRef.world.add(mysteryBlock);
          //   break;
          // case 'Brick':
          //   final BrickBlock brickBlock = BrickBlock(
          //     position: Vector2(obj.x, obj.y),
          //     shouldCrumble: Random().nextBool(),
          //   );
          //   gameRef.world.add(brickBlock);
          gameRef.world.add(_mario);
          break;
        case 'Goomba':
          final Goomba goomba = Goomba(
            position: Vector2(
              obj.x,
              obj.y - 15,
            ),
          );
          gameRef.world.add(goomba);
          break;

        case 'Superman':
          final Superman superman = Superman(
            position: Vector2(
              obj.x,
              obj.y - 15,
            ),
          );
          gameRef.world.add(superman);
          break;

          case 'Doraemon':
          final Doraemon doraemon = Doraemon(
            position: Vector2(
              obj.x,
              obj.y - 15,
            ),
          );
          gameRef.world.add(doraemon);
          break;

          case 'Captain':
          final Captain captain = Captain(
            position: Vector2(
              obj.x,
              obj.y - 15,
            ),
          );
          gameRef.world.add(captain);
          break;

          case 'Thor':
          final Thor thor = Thor(
            position: Vector2(
              obj.x,
              obj.y - 15,
            ),
          );
          gameRef.world.add(thor);
          break;

          case 'Spiderman':
          final Spiderman spiderman = Spiderman(
            position: Vector2(
              obj.x,
              obj.y - 15,
            ),
          );
          gameRef.world.add(spiderman);
          break;

          case 'Hulk':
          final Hulk hulk = Hulk(
            position: Vector2(
              obj.x,
              obj.y - 15,
            ),
          );
          gameRef.world.add(hulk);
          break;

        default:
          break;
      }
    }
  }

  void createPlatform(RenderableTiledMap tileMap) {
    ObjectGroup? platformasLayer = tileMap.getLayer<ObjectGroup>("Platforms");
    if (platformasLayer == null) {
      throw Exception("No platforms layer found");
    }
    for (final TiledObject obj in platformasLayer.objects) {
      Platform platform = Platform(
          position: Vector2(obj.x, obj.y),
          size: Vector2(obj.width, obj.height));
      gameRef.world.add(platform);
      // switch (obj.name) {
      //   case 'Mystery':
      //     final MysteryBlock mysteryBlock = MysteryBlock(
      //       position: Vector2(obj.x, obj.y),
      //     );
      //     gameRef.world.add(mysteryBlock);
      //     break;
      //   case 'Brick':
      //     final BrickBlock brickBlock = BrickBlock(
      //       position: Vector2(obj.x, obj.y),
      //       shouldCrumble: Random().nextBool(),
      //     );
      //     gameRef.world.add(brickBlock);
      //     break;
      //   default:
      //     break;
      // }
    }
  }

  // void createBlocks(RenderableTiledMap tileMap) {
  //   ObjectGroup? blocksLayer = tileMap.getLayer<ObjectGroup>('Blocks');

  //   if (blocksLayer == null) {
  //     throw Exception('Blocks layer not found.');
  //   }

  //   for (final TiledObject obj in blocksLayer.objects) {
  //     switch (obj.name) {
  //       // case 'Brick':
  //       //   final BrickBlock brickBlock = BrickBlock(
  //       //     position: Vector2(obj.x, obj.y),
  //       //     shouldCrumble: Random().nextBool(),

  //       //   );
  //       //   gameRef.world.add(brickBlock);
  //       //   break;
  //       case 'Mystery':
  //         final MysteryBlock mysteryBlock = MysteryBlock(
  //           position: Vector2(obj.x, obj.y),
  //         );
  //         gameRef.world.add(mysteryBlock);
  //         break;
  //       default:
  //         break;
  //     }
  //   }
  // }

  void _setUpCamera() {
    gameRef.cameraComponent.follow(_mario, maxSpeed: 1000);
    gameRef.cameraComponent.setBounds(
      Rectangle.fromPoints(
        _levelBounds.topRight,
        _levelBounds.topLeft,
      ),
    );
  }
}
