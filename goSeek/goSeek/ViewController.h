//
//  ViewController.h
//  goSeek
//
//  Created by Corynne Dech on 4/11/15.
//  Copyright (c) 2015 goSeek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class goSeekConnection;
@class HiderTimer;
@class SeekerTimer;
@class HiderWaitView;
@class SeekerWaitView;
@class HidingView;
@class SeekingView;

@interface ViewController : UIViewController{

}

- (SeekerWaitView*)getSeekerWaitView;
- (HiderWaitView*)getHiderWaitView;
- (SeekerTimer*)getSeekerTimer;
- (HiderTimer*)getHiderTimer;
- (SeekingView*)getSeekingView;
- (HidingView*)getHidingView;
@end

