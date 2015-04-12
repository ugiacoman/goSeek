//
//  HiderWaitView.h
//  goSeek
//
//  Created by Corynne Dech on 4/11/15.
//  Copyright (c) 2015 goSeek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeekerTimer.h"
#import "HiderTimer.h"

@class goSeekConnection;
@class HiderTimer;

@interface HiderWaitView : UIViewController{
    @public goSeekConnection *server;
    @public HiderTimer *hiderTimer;
}

@end

