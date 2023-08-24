import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:tpstreams_player_sdk/services/network.dart';
import 'package:tpstreams_player_sdk/tpstreams_player_sdk.dart';

import '../domain/asset.dart';
import '../models/asset.dart';

class TPStreamPlayer extends StatefulWidget {
  final String assetId;
  final String accessToken;

  TPStreamPlayer({
    Key? key,
    required this.assetId,
    required this.accessToken,
  }) : super(key: key) {
    if (assetId.isEmpty || accessToken.isEmpty) {
      throw ArgumentError("Asset ID and Access token cannot be empty strings");
    }
  }

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
    _controller = BetterPlayerController(getPlayerConfiguration());
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
            _controller.setupDataSource(
                getDataSource(snapshot.data as Asset)
            );
            return AspectRatio(
              aspectRatio: 16 / 9,
              child: BetterPlayer(controller: _controller),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return const Text("Loading");
          }
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
