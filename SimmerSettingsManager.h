@interface SimmerSettingsManager : NSObject

@property (nonatomic, copy) NSDictionary *settings;

@property (nonatomic, readonly) BOOL enabled;
@property (nonatomic, readonly) NSString *source;

+ (instancetype)sharedManager;
- (void)updateSettings;

@end
