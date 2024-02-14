import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:game_portfolio/constants/globals.dart';
import 'package:game_portfolio/constants/sprite_sheets.dart';
import 'package:game_portfolio/games/super_mario_bros_game.dart';

final SuperMarioBrosGame _superMarioBrosGame = SuperMarioBrosGame();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpriteSheets.load();
  await FlameAudio.audioCache.loadAll([
    Globals.jumpSmallSFX,
    Globals.pauseSFX,
    Globals.bumpSFX,
    Globals.powerUpAppearsSFX,
    Globals.breakBlockSFX,
  ]);
  runApp(
    MaterialApp(
      
      debugShowCheckedModeBanner: false,
      home: GameWidget(
        game: _superMarioBrosGame,
      ),
    ),
  );
}
