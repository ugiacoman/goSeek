//
//  HidingView.m
//  goSeek
//
//  Created by Corynne Dech on 4/11/15.
//  Copyright (c) 2015 goSeek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HidingView.h"
#import "network.h"

@interface HidingView ()
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIButton *imOutButton;
@property (strong, nonatomic) IBOutlet UILabel *playersLeftLabel;

@end

@implementation HidingView
bool goingBack;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"IN HIDING VIEW");
    goingBack = false;
    _playersLeftLabel.text = server->_numPlayers;
    // [server requestCountDown];
    
}
- (IBAction)backButtonPushed:(id)sender {
    goingBack = true;
    [self performSegueWithIdentifier:@"HidingBack" sender:self];
    [server requestPlayerRemoved];
}
- (IBAction)imOutButtonPushed:(id)sender {
    [server requestPlayerRemoved];
    [self performSegueWithIdentifier:@"HidingBack" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updatePlayersLeft:(NSString *)playersLeft{
    _playersLeftLabel.text = playersLeft;
    if ([playersLeft isEqual: @"0"]){
        NSLog(@"hider GAME OVER");
        [self performSegueWithIdentifier:@"hiderOver" sender:self];
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