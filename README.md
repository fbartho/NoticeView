NoticeView
==========
A visual component to present a non-invasive notification to the user.

Based off of [tciuro/NoticeView](https://github.com/tciuro/NoticeView)

### Installing

If you're using [CocoPods](http://cocopods.org) it's as simple as:

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

![Displays a red notification with alert icon](https://github.com/levigroker/NoticeView/tree/master/Screenshots/WBNoticeTypeError.png "Displays a red notification with alert icon")

* `WBNoticeTypeSuccess`

![Displays a red notification with alert icon](https://github.com/levigroker/NoticeView/tree/master/Screenshots/WBNoticeTypeSuccess.png "Displays a blue notification with checkmark icon")

* `WBNoticeTypeSticky`

![Displays a grey notification with up arrow icon](https://github.com/levigroker/NoticeView/tree/master/Screenshots/WBNoticeTypeSticky.png "Displays a grey notification")

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
