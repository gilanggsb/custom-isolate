import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'custom_isolate_platform_interface.dart';

/// An implementation of [CustomIsolatePlatform] that uses method channels.
class MethodChannelCustomIsolate extends CustomIsolatePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('custom_isolate');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
