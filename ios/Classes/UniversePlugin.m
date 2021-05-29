#import "UniversePlugin.h"
#if __has_include(<universe/universe-Swift.h>)
#import <universe/universe-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "universe-Swift.h"
#endif

@implementation UniversePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftUniversePlugin registerWithRegistrar:registrar];
}
@end
