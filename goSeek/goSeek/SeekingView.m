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
@property (strong, nonatomic) IBOutlet UIButton *marcoButton;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UILabel *playersLeftLabel;

@end

@implementation SeekingView
bool goingBack;
double currentTime;
double prevTime = 0;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"IN SEEKER TIMER");
    goingBack = false;
    _playersLeftLabel.text = server->_numPlayers;
    
    
//    currentTime = CACurrentMediaTime();
//    if (currentTime - prevTime > 5){
//        [_marcoButton setEnabled:YES];
//        _marcoButton.alpha = 1;
//        prevTime = currentTime;
//    }
    
    
    
    
}
- (IBAction)marcoButton:(id)sender {
    NSLog(@"Imarco button pushed");
    NSLog(@"server: %@", server);
    [server requestMarco];
//    [_marcoButton setEnabled:NO];
//    _marcoButton.alpha = 0.25;
}
- (IBAction)backButtonPushed:(id)sender {
    goingBack = true;
    [self performSegueWithIdentifier:@"SeekingBack" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updatePlayersLeft:(NSString *)playersLeft{
    _playersLeftLabel.text = playersLeft;
    if ([playersLeft isEqual: @"0"]){
        NSLog(@"seeker GAME OVER");
       [self performSegueWithIdentifier:@"seekerOver" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if(goingBack == false){
        
    }
    //    seekerTimer = (UIViewController *)segue.destinationViewController;
    //    // NSLog (@"sending countdown: %@", seekerTimer->countdown);
    //    seekerTimer->server = self->server;
    
}



@end