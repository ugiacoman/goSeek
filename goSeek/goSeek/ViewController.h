//
//  ViewController.h
//  goSeek
//
//  Created by Corynne Dech on 4/11/15.
//  Copyright (c) 2015 goSeek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeekerWaitView.h"
#import "HiderWaitView.h"

@class goSeekConnection;
@class HiderTimer;

@interface ViewController : UIViewController{
    @public NSString *gameCode;

}

- (SeekerTimer*)getSeekerTimer;
- (HiderTimer*)getHiderTimer;
@end

