// ignore_for_file: prefer_mixin

import 'package:custom_isolate/custom_isolate_method_channel.dart';
import 'package:custom_isolate/custom_isolate_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCustomIsolatePlatform
    with MockPlatformInterfaceMixin
    implements CustomIsolatePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final CustomIsolatePlatform initialPlatform = CustomIsolatePlatform.instance;

  test('$MethodChannelCustomIsolate is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCustomIsolate>());
  });

  test('getPlatformVersion', () async {
    // CustomIsolate customIsolatePlugin = CustomIsolate();
    MockCustomIsolatePlatform fakePlatform = MockCustomIsolatePlatform();
    CustomIsolatePlatform.instance = fakePlatform;

    // expect(await customIsolatePlugin.getPlatformVersion(), '42');
  });
}
