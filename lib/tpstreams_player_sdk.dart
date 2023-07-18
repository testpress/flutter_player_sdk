library tpstreams_player_sdk;

import 'dart:math';

export 'widgets/player.dart';

enum PROVIDER {
  tpStreams,
  testpress,
}

class TPStreamsSDK {
  static String? _orgCode;
  static PROVIDER? _provider;

  static void initialize(
      {PROVIDER provider = PROVIDER.tpStreams, required String orgCode}) {
    if (orgCode.isEmpty) {
      throw Exception("Given OrgCode is empty, please pass a valid orgCode");
    }

    _orgCode = orgCode;
    _provider = provider;
  }

  static String get orgCode {
    if (_orgCode == null) {
      throw Exception("OrgCode has not been initialized");
    }

    return _orgCode!;
  }

  static bool get isInitialized => _orgCode != null;

  static bool get isUsedForStreams => _provider == PROVIDER.tpStreams;
}
