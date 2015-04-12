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
@property (strong, nonatomic) IBOutlet UILabel *timerText;

@end

@implementation SeekerTimer

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"IN SEEKER TIMER");
    [server requestCountDown];
    
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
    seekingView = (UIViewController *)segue.destinationViewController;
    seekingView->server = self->server;
    
}



@end
