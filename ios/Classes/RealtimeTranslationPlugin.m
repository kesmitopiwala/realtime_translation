#import "RealtimeTranslationPlugin.h"
#if __has_include(<realtime_translation/realtime_translation-Swift.h>)
#import <realtime_translation/realtime_translation-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "realtime_translation-Swift.h"
#endif

@implementation RealtimeTranslationPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftRealtimeTranslationPlugin registerWithRegistrar:registrar];
}
@end
