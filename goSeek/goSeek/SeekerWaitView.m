//
//  SeekerWaitView.m
//  goSeek
//
//  Created by Corynne Dech on 4/11/15.
//  Copyright (c) 2015 goSeek. All rights reserved.
//

#import "SeekerWaitView.h"
#import "SeekerTimer.h"

@interface SeekerWaitView ()

@property (weak, nonatomic) IBOutlet UILabel *gameCode;

@end
UIButton *playButton;
SeekerTimer *timer;
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
    timer = (UIViewController *)segue.destinationViewController;
    timer->countdown = self->countdown;
    NSLog (@"sending countdown: %@", timer->countdown);
    timer->server = self->server;
    
}



@end


//- (void)update:(CCTime)delta