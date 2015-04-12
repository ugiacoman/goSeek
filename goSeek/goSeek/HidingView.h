//
//  HidingView.h
//  goSeek
//
//  Created by Corynne Dech on 4/11/15.
//  Copyright (c) 2015 goSeek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HiderWaitView.h"

@class HiderTimer;
@class goSeekConnection;

@interface HidingView : UIViewController{
@public goSeekConnection *server;
}

- (void) updatePlayersLeft: (NSString *)playersLeft;

@end

