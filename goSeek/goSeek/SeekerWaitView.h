//
//  SeekerWaitView.h
//  goSeek
//
//  Created by Corynne Dech on 4/11/15.
//  Copyright (c) 2015 goSeek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeekerTimer.h"

@class goSeekConnection;
@class SeekerTimer;

@interface SeekerWaitView : UIViewController{
        @public NSString *roomCode;
        @public NSString *countdown;
        @public goSeekConnection *server;
        @public SeekerTimer *seekerTimer;
}

@end

