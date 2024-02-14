import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:game_portfolio/constants/globals.dart';

class SpriteSheets {
  static late SpriteSheet itemBlocksSpriteSheet;
  static late SpriteSheet goombaSpriteSheet;
  static late SpriteSheet supermanSpriteSheet;
  static late SpriteSheet spidermanSpriteSheet;
  static late SpriteSheet doraemonSpriteSheet;
  static late SpriteSheet thorSpriteSheet;
  static late SpriteSheet hulkSpriteSheet;
  static late SpriteSheet captainSpriteSheet;

  static Future<void> load() async {
    // Item Blocks Sprite Sheet
    final itemBlocksSpriteSheetImage = await Flame.images.load(
      Globals.blocksSpriteSheet,
    );
    itemBlocksSpriteSheet = SpriteSheet.fromColumnsAndRows(
      image: itemBlocksSpriteSheetImage,
      columns: 28,
      rows: 16,
    );

    // Goomba Sprite Sheet
    final goombaSpriteSheetImage = await Flame.images.load(
      Globals.goombaSpriteSheet,
    );
    goombaSpriteSheet = SpriteSheet.fromColumnsAndRows(
      image: goombaSpriteSheetImage,
      columns: 3,
      rows: 1,
    );

    final supermanSpriteSheetImage = await Flame.images.load(
      Globals.spermanSprite,
    );
    supermanSpriteSheet = SpriteSheet.fromColumnsAndRows(
      image: supermanSpriteSheetImage,
      columns: 3,
      rows: 1,
    );

    final spidermanSpriteSheetImage = await Flame.images.load(
      Globals.spidermanSprite,
    );
    spidermanSpriteSheet = SpriteSheet.fromColumnsAndRows(
      image: spidermanSpriteSheetImage,
      columns: 3,
      rows: 1,
    );

    final doraemonSpriteSheetImage = await Flame.images.load(
      Globals.doraemonSprite,
    );
    doraemonSpriteSheet = SpriteSheet.fromColumnsAndRows(
      image: doraemonSpriteSheetImage,
      columns: 3,
      rows: 1,
    );

    final thorSpriteSheetImage = await Flame.images.load(
      Globals.thorSprite,
    );
    thorSpriteSheet = SpriteSheet.fromColumnsAndRows(
      image: thorSpriteSheetImage,
      columns: 3,
      rows: 1,
    );

    final hulkSpriteImage = await Flame.images.load(
      Globals.hulkSprite,
    );
    hulkSpriteSheet = SpriteSheet.fromColumnsAndRows(
      image: hulkSpriteImage,
      columns: 3,
      rows: 1,
    );

    final captainSpriteSheetImage = await Flame.images.load(
      Globals.captainSprite,
    );
    captainSpriteSheet = SpriteSheet.fromColumnsAndRows(
      image: captainSpriteSheetImage,
      columns: 3,
      rows: 1,
    );
  }
}
