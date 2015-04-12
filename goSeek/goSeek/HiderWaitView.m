//
//  HiderWaitView.m
//  goSeek
//
//  Created by Corynne Dech on 4/11/15.
//  Copyright (c) 2015 goSeek. All rights reserved.
//

#import "HiderWaitView.h"
#import "network.h"

@interface HiderWaitView ()
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UILabel *playersLeftLabel;

@end

@implementation HiderWaitView
BOOL goingBack;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    goingBack = false;
    NSLog (@"IN HIDER VIEW");
    
}
- (IBAction)backButtonPressed:(id)sender {
    goingBack = true;
    [self performSegueWithIdentifier:@"HiderWaitBack" sender:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if(goingBack == false){
        hiderTimer = (UIViewController *)segue.destinationViewController;
        hiderTimer->server = server;
    }
}

- (void) updatePlayersLeft:(NSString *)playersLeft{
    _playersLeftLabel.text = playersLeft;
    if ([playersLeft isEqual: @"0"]){
        NSLog(@"countdown finished");
        [self performSegueWithIdentifier:@"startHiderTimer" sender:self];
    }
}



@end


//- (void)update:(CCTime)delta