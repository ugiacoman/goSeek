//
//  SeekingView.h
//  goSeek
//
//  Created by Corynne Dech on 4/11/15.
//  Copyright (c) 2015 goSeek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeekerWaitView.h"

@class SeekerTimer;
@class goSeekConnection;

@interface SeekingView : UIViewController{
    @public goSeekConnection *server;
}

- (void) updatePlayersLeft: (NSString *)playersLeft;

@end

