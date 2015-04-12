//
//  HiderTimer.h
//  goSeek
//
//  Created by Corynne Dech on 4/11/15.
//  Copyright (c) 2015 goSeek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class goSeekConnection;
@class HiderWaitView;
@class HidingView;

@interface HiderTimer : UIViewController{
@public goSeekConnection *server;
@public HidingView *hidingView;
}

- (void) updateCountdown: (NSString *)countdown;

@end
