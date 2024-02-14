import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:game_portfolio/constants/animation_configs.dart';
import 'package:game_portfolio/constants/globals.dart';
import 'package:game_portfolio/games/super_mario_bros_game.dart';
import 'package:game_portfolio/objects/game_block.dart';
import 'package:url_launcher/url_launcher.dart';

class MysteryBlock extends GameBlock with HasGameRef<SuperMarioBrosGame> {
  bool _hit = false;

  MysteryBlock({
    required Vector2 position,
  }) : super(
          animation: AnimationConfigs.block.mysteryBlockIdle(),
          position: position,
          shouldCrumble: false,
        );

  @override
  void hit() async {
    animation = AnimationConfigs.block.brickBlockHit();
    FlameAudio.play(Globals.breakBlockSFX);

    if (!_hit) {
      _hit = true;

      // Updated to empty block animation.
      animation = AnimationConfigs.block.mysteryBlockHit();
      AnimationConfigs.mario.idle();
      const urlString = 'https://github.com'; // Example URL
      Uri url = Uri.parse(urlString);
      await launchUrl(url);
      AnimationConfigs.mario.idle();
    }

    super.hit();
  }
}
