#import "UIImage+AnimatedGif.h"
#import "SimmerSettingsManager.h"
#define BUNDLE_PATH @"/Library/MobileSubstrate/DynamicLibraries/com.brycedev.simmerdown.bundle"

%hook SBPowerDownController

- (void)powerDownViewRequestPowerDown:(UIView *)view {
	NSString *source = [[SimmerSettingsManager sharedManager] source];
	NSBundle *bundle = [[[NSBundle alloc] initWithPath:BUNDLE_PATH] autorelease];
	NSURL *path = [bundle URLForResource:source withExtension:@"gif"];
	NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString: [path absoluteString]]];
	if(imageData != nil && [[SimmerSettingsManager sharedManager] enabled]){
		UIImage *image = [UIImage animatedImageWithAnimatedGIFData: imageData];
		CGFloat ow = image.size.width;
		CGFloat oh = image.size.height;
		CGFloat ratio = ow / oh;
		UIImageView *iv = [[UIImageView alloc] init];
		[iv setFrame: CGRectMake(0,0, view.frame.size.width, view.frame.size.width / ratio )];
		[iv setContentMode: UIViewContentModeScaleAspectFill];
		[iv setAnimationDuration: image.duration];
		[iv setAnimationRepeatCount: 1];
		[iv setAnimationImages: image.images];
		CGRect rect = CGRectMake(0, 0, 1, 1);
	    UIGraphicsBeginImageContext(rect.size);
	    CGContextRef context = UIGraphicsGetCurrentContext();
	    CGContextSetFillColorWithColor(context, [[UIColor blackColor] CGColor]);
	    CGContextFillRect(context, rect);
	    UIImage *blackImage = UIGraphicsGetImageFromCurrentImageContext();
	    UIGraphicsEndImageContext();
		[iv setImage: blackImage];
		UIView *simmerView = [[UIView alloc] initWithFrame: [view frame]];
		[simmerView setBackgroundColor: [UIColor clearColor]];
		[simmerView addSubview: iv];
		[iv setCenter: simmerView.center];
		[view addSubview: simmerView];
		[iv startAnimating];
		%orig;
		/* TESTING
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (image.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			HBLogInfo(@"would actually power down now");
			[self cancel];
		});
		*/
	}
	else {
		%orig;
	}
}

%end

%ctor {
	[SimmerSettingsManager sharedManager];
}
