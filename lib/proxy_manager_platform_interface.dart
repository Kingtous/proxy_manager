import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'proxy_manager.dart';
import 'proxy_manager_method_channel.dart';

abstract class ProxyManagerPlatform extends PlatformInterface {
  /// Constructs a ProxyManagerPlatform.
  ProxyManagerPlatform() : super(token: _token);

  static final Object _token = Object();

  static ProxyManagerPlatform _instance = MethodChannelProxyManager();

  /// The default instance of [ProxyManagerPlatform] to use.
  ///
  /// Defaults to [MethodChannelProxyManager].
  static ProxyManagerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ProxyManagerPlatform] when
  /// they register themselves.
  static set instance(ProxyManagerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> setSystemProxy(ProxyTypes types, String url, int port) async {
    throw UnimplementedError('setSystemProxy() has not been implemented.');
  }

  Future<void> cleanSystemProxy() async {
    throw UnimplementedError('cleanSystemProxy() has not been implemented.');
  }
}
