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

@property (weak, nonatomic) IBOutlet UILabel *gameCode;

@end
UIButton *playButton;
@implementation SeekerWaitView
- (IBAction)playButton:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _gameCode.text = roomCode;
    NSLog (@"IN NEW VIEW");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    seekerTimer = (UIViewController *)segue.destinationViewController;
   // NSLog (@"sending countdown: %@", seekerTimer->countdown);
    seekerTimer->server = self->server;
    
}



@end


//- (void)update:(CCTime)delta