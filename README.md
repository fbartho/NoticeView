NoticeView
==========
A visual component for iOS to present a dynamically sized, non-invasive notification to the user.

Based off of [tciuro/NoticeView](https://github.com/tciuro/NoticeView) and [levigroker/NoticeView](https://github.com/levigroker/NoticeView)

### Installing

If you're using [CocoPods](http://cocopods.org) it's as simple as adding this to your `Podfile`:

	pod 'NoticeView', :git => 'https://github.com/levigroker/NoticeView.git'

### Documentation

	+ (WBNoticeView *)noticeOfType:(WBNoticeType)noticeType
							inView:(UIView *)view
							 title:(NSString *)title
						   message:(NSString *)message
						  duration:(NSTimeInterval)duration
					dismissedBlock:(WBNoticeViewDismissedBlock)dismissedBlock;

#### WBNoticeType

* `WBNoticeTypeError`

![Displays a red notification with alert icon](https://github.com/levigroker/NoticeView/blob/master/Screenshots/WBNoticeTypeError.png?raw=true "Displays a red notification with alert icon")

* `WBNoticeTypeSuccess`

![Displays a red notification with alert icon](https://github.com/levigroker/NoticeView/blob/master/Screenshots/WBNoticeTypeSuccess.png?raw=true "Displays a blue notification with checkmark icon")

* `WBNoticeTypeSticky`

![Displays a grey notification with up arrow icon](https://github.com/levigroker/NoticeView/blob/master/Screenshots/WBNoticeTypeSticky.png?raw=true "Displays a grey notification with up arrow icon")

#### Examples

Displays an "error" notification which will be displayed on the screen for
`kErrorAlertNotificationDisplayTime` (a constant you define):

	WBNoticeView *notice = [WBNoticeView noticeOfType:WBNoticeTypeError inView:self.view title:NSLocalizedString(@"That didn’t work.", nil) message:NSLocalizedString(@"Whatever you just did didn't work. Please try again.", nil) duration:kErrorAlertNotificationDisplayTime dismissedBlock:nil];
	[notice show];

Displays a "success" notification for one and a half seconds, or is dismissed by the user,
and provides a block to get executed when the notification is dismissed:

    WBNoticeView *notice = [WBNoticeView noticeOfType:WBNoticeTypeSuccess inView:self.view title:@"7 New Tweets arrived somewhere from the intertubes." message:nil duration:1.5f dismissedBlock:^(BOOL userDismissed) {
        NSLog(@"User did%@ dismiss the notification.", userDismissed ? @"" : @" not");
    }];
    [notice show];
