import 'package:flutter_test/flutter_test.dart';
import 'package:proxy_manager/proxy_manager.dart';
import 'package:proxy_manager/proxy_manager_platform_interface.dart';
import 'package:proxy_manager/proxy_manager_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockProxyManagerPlatform
    with MockPlatformInterfaceMixin
    implements ProxyManagerPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ProxyManagerPlatform initialPlatform = ProxyManagerPlatform.instance;

  test('$MethodChannelProxyManager is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelProxyManager>());
  });

  test('getPlatformVersion', () async {
    ProxyManager proxyManagerPlugin = ProxyManager();
    MockProxyManagerPlatform fakePlatform = MockProxyManagerPlatform();
    ProxyManagerPlatform.instance = fakePlatform;

    expect(await proxyManagerPlugin.getPlatformVersion(), '42');
  });
}
