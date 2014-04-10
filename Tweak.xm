//Planned:
//Hide STU arrow -- done
//Set legal text -- done
//Hide slider, custom text -- done
//Hide cam grabber
//Hide Nc and CC grabbers
//Hide clock + date
//Prefs values

#define kSettingsPath [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Preferences/com.phillipt.lockcustomizer.plist"]
#define kIsEnabled [[[NSDictionary dictionaryWithContentsOfFile:kSettingsPath] objectForKey:@"isEnabled"] boolValue]
#define kHideSlide [[[NSDictionary dictionaryWithContentsOfFile:kSettingsPath] objectForKey:@"hideSlide"] boolValue]
#define kCustomSlideText [[NSDictionary dictionaryWithContentsOfFile:kSettingsPath] objectForKey:@"customSlideText"]
#define kCustomLegal [[NSDictionary dictionaryWithContentsOfFile:kSettingsPath] objectForKey:@"customLegalText"]
#define kHideArrow [[[NSDictionary dictionaryWithContentsOfFile:kSettingsPath] objectForKey:@"hideArrow"] boolValue]
#define kLegalText [[[NSDictionary dictionaryWithContentsOfFile:kSettingsPath] objectForKey:@"legalText"] boolValue]
#define kHideDate [[[NSDictionary dictionaryWithContentsOfFile:kSettingsPath] objectForKey:@"hideDate"] boolValue]
#define kHideTimeAndDate [[[NSDictionary dictionaryWithContentsOfFile:kSettingsPath] objectForKey:@"hideTimeAndDate"] boolValue]

NSMutableDictionary *prefs = nil;

//Custom 'slide to unlock' text
%hook SBLockScreenView

- (void)setCustomSlideToUnlockText:(id)text {

	if (kIsEnabled && !kHideSlide) {

		if ([kCustomSlideText isEqual:@""]) {

			%orig(text);

		}

		else {

			text = kCustomSlideText;
			%orig(text);

		}


	}

	else if (kIsEnabled && kHideSlide) {

		text = @"";
		%orig(text);

	}

	else if (!kIsEnabled) {

		%orig(text);

	}

	else {

		text = kCustomSlideText;
		%orig(text);

	}

	%orig(text);

}

%end

//Hide STU arrow
%hook SBFGlintyStringView

-(int)chevronStyle {

    if (kIsEnabled && kHideArrow) {
        
        return 0;
                
    }
    
    return %orig;
    
}

 -(void)setChevronStyle:(int) style {
 
    //If chevron turned on, turn it on
    if (kIsEnabled && kHideArrow) {

        style = 0;
        %orig(style);

    }
 
    %orig(style);
 
}


%end

//Hook to remove date + 
%hook SBLockScreenViewController

- (BOOL)_shouldShowDate {

	if (kIsEnabled && kHideDate) {

		return FALSE;

	}

	return %orig;

}

- (float)_effectiveOpacityForVisibleDateView {

	if (kIsEnabled && kHideTimeAndDate) {

		return 0.0;

	}

	return %orig;

}

%end

//Set legal text
%hook SBLockScreenLegalViewController

- (BOOL)_shouldShowLegalText {

    if (kIsEnabled && kLegalText) {

    	return TRUE;

    }

    return %orig;

}

- (id)_legalString {

    if (kIsEnabled && kLegalText) {
    
    	if ([kCustomLegal isEqual:@""]) {

    		return %orig;

    	}

    	else {

    		return kLegalTextf;

    	}

	}

	return %orig;

	//return %orig;

}

%end

void loadPreferences() {

	prefs = [NSMutableDictionary dictionaryWithContentsOfFile:kSettingsPath];

	NSLog(@"%@", [prefs description]);

}

%ctor {
    // Initialization stuff
    
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                    NULL,
                                    (CFNotificationCallback)loadPreferences,
                                    CFSTR("com.phillipt.lockcustomizer/preferencechanged"),
                                    NULL,
                                    CFNotificationSuspensionBehaviorDeliverImmediately);
    
    loadPreferences();

}