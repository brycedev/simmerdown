#import "BDSettingsManager.h"

@implementation BDSettingsManager

+ (instancetype)sharedManager {
    static dispatch_once_t p = 0;
    __strong static id _sharedSelf = nil;
    dispatch_once(&p, ^{
        _sharedSelf = [[self alloc] init];
    });
    return _sharedSelf;
}

void prefschanged(CFNotificationCenterRef center, void * observer, CFStringRef name, const void * object, CFDictionaryRef userInfo) {
    [[BDSettingsManager sharedManager] updateSettings];
}

- (id)init {
    if (self = [super init]) {
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, prefschanged, CFSTR("com.brycedev.simmerdown"), NULL, CFNotificationSuspensionBehaviorCoalesce);
        [self updateSettings];
    }
    return self;
}

- (void)updateSettings {
    self.settings = nil;
    CFPreferencesAppSynchronize(CFSTR("com.brycedev.simmerdown"));
    CFStringRef appID = CFSTR("com.brycedev.simmerdown");
    CFArrayRef keyList = CFPreferencesCopyKeyList(appID , kCFPreferencesCurrentUser, kCFPreferencesAnyHost) ?: CFArrayCreate(NULL, NULL, 0, NULL);
    self.settings = (NSDictionary *)CFPreferencesCopyMultiple(keyList, appID , kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
    CFRelease(keyList);
}

- (BOOL)enabled {
    return self.settings[@"enabled"] ? [self.settings[@"enabled"] boolValue] : YES;
}

- (NSString *)source {
    NSInteger val = self.settings[@"source"] ? [self.settings[@"source"] integerValue] : 0;
    if(val == 0){
        return @"abso";
    }else if(val == 1){
        return @"bye";
    }
    return @"abso";
}

@end
