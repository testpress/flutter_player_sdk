import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:tpstreams_player_sdk/services/streams.dart';
import 'package:tpstreams_player_sdk/tpstreams_player_sdk.dart';

import '../models/asset.dart';

class TPStreamPlayer extends StatefulWidget {
  final String assetId;
  final String accessToken;

  const TPStreamPlayer({
    Key? key,
    required this.assetId,
    required this.accessToken,
  }) : super(key: key);

  @override
  State<TPStreamPlayer> createState() => _TPStreamPlayerState();
}

class _TPStreamPlayerState extends State<TPStreamPlayer> {
  late BetterPlayerController _controller;
  late Future<Asset> _assetFuture;

  @override
  void initState() {
    super.initState();
    _assetFuture = fetchAsset(widget.assetId, widget.accessToken);
  }

  @override
  Widget build(BuildContext context) {
    if (!TPStreamsSDK.isInitialized) {
      throw Exception(
          'SDK not initialized. Call TPStreamsSDK.initialize() first.');
    }

    return FutureBuilder(
        future: _assetFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _controller = getPlayerController(snapshot.data as Asset);
            return AspectRatio(
              aspectRatio: 16 / 9,
              child: BetterPlayer(controller: _controller),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  BetterPlayerController getPlayerController(Asset asset) {
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

  void pauseVideo() {
    _controller.pause();
  }

  void seekTo(Duration position) {
    _controller.seekTo(position);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
