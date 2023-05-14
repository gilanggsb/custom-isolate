//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <custom_isolate/custom_isolate_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) custom_isolate_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "CustomIsolatePlugin");
  custom_isolate_plugin_register_with_registrar(custom_isolate_registrar);
}
