//
//  SeekerTimer.m
//  goSeek
//
//  Created by Corynne Dech on 4/11/15.
//  Copyright (c) 2015 goSeek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SeekerTimer.h"
#import "SeekingView.h"
#import "network.h"

@interface SeekerTimer ()
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UILabel *timerText;

@end

@implementation SeekerTimer
bool goingBack;

- (void)viewDidLoad {
    [super viewDidLoad];
    goingBack = false;
    NSLog(@"IN SEEKER TIMER");
    NSLog(@"server: %@", server);
    
    goSeekConnection *conn = [[goSeekConnection alloc] init:self];
    
    //[conn setRoomcode:[server getRoomCode]];
//    conn->_roomcode = [server valueForKey:@"_roomcode"];
    [conn requestCountDown:(NSString*)[server getRoomCode]];
    
}
- (IBAction)backButtonPushed:(id)sender {
    goingBack = true;
    [self performSegueWithIdentifier:@"SeekerTimerBack" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateCountdown: (NSString *)countdown{
    NSLog(@"updating countdown: %@", countdown);
    _timerText.text = countdown;
    if ([countdown isEqual: @"0"]){
        NSLog(@"countdown finished");
        [self performSegueWithIdentifier:@"startSeeking" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if(goingBack == false){
    seekingView = (UIViewController *)segue.destinationViewController;
    seekingView->server = server;
    }
    
}



@end
