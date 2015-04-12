//
//  HiderTimer.m
//  goSeek
//
//  Created by Corynne Dech on 4/11/15.
//  Copyright (c) 2015 goSeek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HiderTimer.h"
#import "HidingView.h"
#import "network.h"

@interface HiderTimer ()
@property (strong, nonatomic) IBOutlet UILabel *timerText;

@end

@implementation HiderTimer

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"IN HIDER TIMER");
    [server requestCountDown];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateCountdown: (NSString *)countdown{
    _timerText.text = countdown;
    if ([countdown isEqual: @"0"]){
        NSLog(@"countdown finished");
        [self performSegueWithIdentifier:@"startHiding" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    hidingView = (UIViewController *)segue.destinationViewController;
    hidingView->server = self->server;
    
}

@end