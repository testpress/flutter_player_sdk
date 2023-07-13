import 'package:better_player/better_player.dart';

import '../models/asset.dart';

BetterPlayerController getPlayerControllerForAsset(Asset asset) {
  return BetterPlayerController(
    const BetterPlayerConfiguration(
      autoPlay: true,
      aspectRatio: 16 / 9,
      controlsConfiguration: BetterPlayerControlsConfiguration(
        enablePlayPause: true,
        enableFullscreen: true,
      ),
    ),
    betterPlayerDataSource: BetterPlayerDataSource(
        BetterPlayerDataSourceType.network, asset.video.getPlaybackURL()),
  );
}
