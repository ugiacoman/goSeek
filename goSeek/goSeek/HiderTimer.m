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
@property (strong, nonatomic) IBOutlet UIButton *backButton;

@end

@implementation HiderTimer
bool goingBack;
- (void)viewDidLoad {
    [super viewDidLoad];
    goingBack = false;
    NSLog(@"IN HIDER TIMER");
    [server requestCountDown];
    
}
- (IBAction)backButtonPushed:(id)sender {
    goingBack = true;
    [self performSegueWithIdentifier:@"HiderTimerBack" sender:self];
    [server requestPlayerRemoved];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateCountdown: (NSString *)countdown{
    _timerText.text = countdown;
    NSLog(@"countdown RECIEVED: %@", countdown);
    if ([countdown isEqual: @"0"]){
        NSLog(@"countdown finished");
        [self performSegueWithIdentifier:@"startHiding" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if(goingBack == false){
        hidingView = (UIViewController *)segue.destinationViewController;
        hidingView->server = self->server;
    }
    
}

@end