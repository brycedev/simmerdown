%hook SBPowerDownController

- (id)init {

	return %orig;
}

- (void)powerDownViewRequestPowerDown:(UIView *)view {

	HBLogInfo(@"requested power down with view : %@", view);
	UIView *simmerView = [[UIView alloc] initWithFrame: [view frame]];
	[simmerView setBackgroundColor: [UIColor whiteColor]];
	[view addSubview: simmerView];

}

- (void)powerDown {
	//don't return %orig to prevent actually shutting it down for now :D
	HBLogInfo(@"power down function being called");
}

- (void)actionSlider:(id)arg1 didUpdateSlideWithValue:(double)value {
	HBLogInfo(@"the value is : %f", value);
}

%end

%hook SBPowerDownView

- (id)initWithFrame:(CGRect)frame {
	MSHookIvar<BOOL>(self, "_canAlterScreenBrightness") = NO;
	return %orig;
}

%end
