#import <Preferences/Preferences.h>

@interface LockCustomizerListController: PSListController {
}
@end

@implementation LockCustomizerListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"LockCustomizer" target:self] retain];
	}
	return _specifiers;
}
@end

// vim:ft=objc
