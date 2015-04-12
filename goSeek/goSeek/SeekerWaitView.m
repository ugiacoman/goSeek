//
//  SeekerWaitView.m
//  goSeek
//
//  Created by Corynne Dech on 4/11/15.
//  Copyright (c) 2015 goSeek. All rights reserved.
//

#import "SeekerWaitView.h"
#import "SeekerTimer.h"
#import "network.h"

@interface SeekerWaitView ()

@property (strong, nonatomic) IBOutlet UILabel *roomCodeLabel;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UILabel *playersLeftLabel;

@end
UIButton *playButton;
BOOL goingBack;
@implementation SeekerWaitView
- (IBAction)playButton:(id)sender {
}
- (IBAction)backButtonPressed:(id)sender {
    goingBack = true;
    [self performSegueWithIdentifier:@"SeekerWaitBack" sender:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    goingBack = false;
    // Do any additional setup after loading the view, typically from a nib.
   // _roomCodeLabel.text = roomCode;
    NSLog (@"IN NEW VIEW");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if(goingBack == false){
        seekerTimer = (UIViewController *)segue.destinationViewController;
        seekerTimer->server = server;
    }
}

- (void) updateRoomCode: (NSString *)roomCodeUpdate{
    NSLog (@"Updating room code %@", roomCodeUpdate);
   _roomCodeLabel.text = roomCodeUpdate;
}

- (void) updatePlayersLeft:(NSString *)playersLeft{
    NSLog (@"Updating players left %@", playersLeft);
    _playersLeftLabel.text = playersLeft;
     NSLog (@"now is %@", _playersLeftLabel.text);
}



@end


//- (void)update:(CCTime)delta