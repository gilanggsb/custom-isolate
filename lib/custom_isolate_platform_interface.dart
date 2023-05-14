import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'custom_isolate_method_channel.dart';

abstract class CustomIsolatePlatform extends PlatformInterface {
  /// Constructs a CustomIsolatePlatform.
  CustomIsolatePlatform() : super(token: _token);

  static final Object _token = Object();

  static CustomIsolatePlatform _instance = MethodChannelCustomIsolate();

  /// The default instance of [CustomIsolatePlatform] to use.
  ///
  /// Defaults to [MethodChannelCustomIsolate].
  static CustomIsolatePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CustomIsolatePlatform] when
  /// they register themselves.
  static set instance(CustomIsolatePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
