//
//  SeekerTimer.m
//  goSeek
//
//  Created by Corynne Dech on 4/11/15.
//  Copyright (c) 2015 goSeek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SeekerTimer.h"

@interface SeekerTimer ()
@property (strong, nonatomic) IBOutlet UILabel *timerText;

@end

@implementation SeekerTimer

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"IN SEEKER TIMER");
    [server requestCountDown];
    _timerText.text = countdown;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
