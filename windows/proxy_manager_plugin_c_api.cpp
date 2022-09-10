#include "include/proxy_manager/proxy_manager_plugin.h"

#include <flutter/plugin_registrar_windows.h>

#include "proxy_manager_plugin.h"

void ProxyManagerPluginRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  proxy_manager::ProxyManagerPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
