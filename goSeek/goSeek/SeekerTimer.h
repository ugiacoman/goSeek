//
//  SeekerTimer.h
//  goSeek
//
//  Created by Corynne Dech on 4/11/15.
//  Copyright (c) 2015 goSeek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class goSeekConnection;
@class SeekerWaitView;
@class SeekingView;

@interface SeekerTimer : UIViewController{
    @public goSeekConnection *server;
    @public SeekingView *seekingView;
}

- (void) updateCountdown: (NSString *)countdown;

@end

