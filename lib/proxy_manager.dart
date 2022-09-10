// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'dart:io';

import 'proxy_manager_platform_interface.dart';
import 'package:path/path.dart' as path;

enum ProxyTypes { http, https, socks }

class ProxyManager {

  Future<String?> getPlatformVersion() {
    return ProxyManagerPlatform.instance.getPlatformVersion();
  }

  void setAsSystemProxy(ProxyTypes types, String url, int port) {
    switch (Platform.operatingSystem) {
      case "windows":
        setAsSystemProxyWindows(types, url, port);
        break;
      case "linux":
        setAsSystemProxyLinux(types, url, port);
        break;
      case "macos":
        // TODO
        break;
    }
  }

  Future<void> setAsSystemProxyWindows(ProxyTypes types, String url, int port) async {
     ProxyManagerPlatform.instance.setSystemProxy(types, url, port);
  }

  void setAsSystemProxyLinux(ProxyTypes types, String url, int port) {
    final homeDir = Platform.environment['HOME']!;
    final configDir = path.join(homeDir, ".config");
    final cmdList = List<List<String>>.empty(growable: true);
    final desktop = Platform.environment['XDG_CURRENT_DESKTOP'];
    final isKDE = desktop == "KDE";
    // gsetting
    cmdList
        .add(["gsettings", "set", "org.gnome.system.proxy", "mode", "manual"]);
    cmdList.add([
      "gsettings",
      "set",
      "org.gnome.system.proxy.${types.name}",
      "host",
      "$url"
    ]);
    cmdList.add([
      "gsettings",
      "set",
      "org.gnome.system.proxy.${types.name}",
      "port",
      "$port"
    ]);
    // kde
    if (isKDE) {
      cmdList.add([
        "kwriteconfig5",
        "--file",
        "$configDir/kioslaverc",
        "--group",
        "Proxy Settings",
        "--key",
        "ProxyType",
        "1"
      ]);
      cmdList.add([
        "kwriteconfig5",
        "--file",
        "$configDir/kioslaverc",
        "--group",
        "Proxy Settings",
        "--key",
        "${types.name}Proxy",
        "${types.name}://$url:$port"
      ]);
    }
    for (final cmd in cmdList) {
      final res = Process.runSync(cmd[0], cmd.sublist(1), runInShell: true);
      print('cmd: $cmd returns ${res.exitCode}');
    }
  }

  void cleanSystemProxy() {
    switch (Platform.operatingSystem) {
      case "linux":
        cleanSystemProxyLinux();
        break;
      case "windows":
        cleanSystemProxyWindows();
        break;
    }
  }

  void cleanSystemProxyWindows() {
    ProxyManagerPlatform.instance.cleanSystemProxy();
  }

  void cleanSystemProxyLinux() {
    final homeDir = Platform.environment['HOME']!;
    final configDir = path.join(homeDir, ".config/");
    final cmdList = List<List<String>>.empty(growable: true);
    final desktop = Platform.environment['XDG_CURRENT_DESKTOP'];
    final isKDE = desktop == "KDE";
    // gsetting
    cmdList.add(["gsettings", "set", "org.gnome.system.proxy", "mode", "none"]);
    if (isKDE) {
      cmdList.add([
        "kwriteconfig5",
        "--file",
        "$configDir/kioslaverc",
        "--group",
        "Proxy Settings",
        "--key",
        "ProxyType",
        "0"
      ]);
    }
    for (final cmd in cmdList) {
      final res = Process.runSync(cmd[0], cmd.sublist(1));
      print('cmd: $cmd returns ${res.exitCode}');
    }
  }
}
