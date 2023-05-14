#include "include/custom_isolate/custom_isolate_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "custom_isolate_plugin.h"

void CustomIsolatePluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  custom_isolate::CustomIsolatePlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
