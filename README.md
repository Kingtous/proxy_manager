# ProxyManager for Flutter

[pub-image]: https://img.shields.io/pub/v/proxy_manager.svg
[pub-url]: https://pub.dev/packages/proxy_manager

## Features

-  set/clean system proxy settings for all desktop platforms
    - windows
    - linux(kde/gnome/dde)
    - macOS

## Example 

```dart
// single instance
ProxyManager manager = ProxyManager();
// set a http proxy
await manager.setAsSystemProxy(ProxyTypes.http, "127.0.0.1", 1087);
// set a https proxy
await manager.setAsSystemProxy(ProxyTypes.https, "127.0.0.1", 1087);
// set a socks4/5 proxy
await manager.setAsSystemProxy(ProxyTypes.socks, "127.0.0.1", 1080);
```