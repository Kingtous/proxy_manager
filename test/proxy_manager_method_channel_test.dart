import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proxy_manager/proxy_manager_method_channel.dart';

void main() {
  MethodChannelProxyManager platform = MethodChannelProxyManager();
  const MethodChannel channel = MethodChannel('proxy_manager');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
