import 'package:flutter/material.dart';
import 'package:tpstreams_player_sdk/tpstreams_player_sdk.dart';

void main() {
  TPStreamsSDK.initialize(orgCode: "9mpasc");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Streams Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Streams Demo"),
      ),
      body: const Column(
        children: [
          TPStreamPlayer(
              assetId: 'be922588-f33b-4fcb-953c-64bf048b8952',
              accessToken: '159c06de-0e70-472c-a4e6-5a7edd25d264')
        ],
      ),
    );
  }
}
