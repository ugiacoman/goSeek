//
//  SeekingView.m
//  goSeek
//
//  Created by Corynne Dech on 4/11/15.
//  Copyright (c) 2015 goSeek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SeekingView.h"
#import "network.h"

@interface SeekingView ()
@property (strong, nonatomic) IBOutlet UILabel *playersLeftLabel;
@property (strong, nonatomic) IBOutlet UIButton *marcoButton;

@end

@implementation SeekingView

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"IN SEEKER TIMER");
   // [server requestCountDown];
    
}
- (IBAction)marcoButton:(id)sender {
    [server requestMarco];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updatePlayersLeft:(NSString *)playersLeft{
    _playersLeftLabel.text = playersLeft;
    if ([playersLeft isEqual: @"0"]){
        NSLog(@"countdown finished");
       // [self performSegueWithIdentifier:@"startSeeking" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //    seekerTimer = (UIViewController *)segue.destinationViewController;
    //    // NSLog (@"sending countdown: %@", seekerTimer->countdown);
    //    seekerTimer->server = self->server;
    
}



@end