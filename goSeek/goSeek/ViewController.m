//
//  ViewController.m
//  goSeek
//
//  Created by Corynne Dech on 4/11/15.
//  Copyright (c) 2015 goSeek. All rights reserved.
//

#import "ViewController.h"
#import "SeekerWaitView.h"
#import "EventSource.h"
#import <AudioToolbox/AudioToolbox.h>
#import "network.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIButton *startGame;
@property (strong, nonatomic) IBOutlet UITextField *gameCodeField;
@end




@implementation ViewController

- (IBAction)gameCodeField:(id)sender {
}


@synthesize gameCodeField;
- (IBAction)updateInput:(id)sender {
    
}
- (IBAction)textChanged:(id)sender {
    
    
}

- (IBAction)returnKeyButton:(id)sender {
    NSString *inputCode;
    inputCode = gameCodeField.text;
    NSLog (@"%@", inputCode);
    if(gameCodeField == nil){
        NSLog(@"FIELD NULL");
    }
    NSLog(@"returnkey");
        [sender resignFirstResponder];
}
- (IBAction)startGame:(id)sender {
    NSLog (@"%@", gameCode);
    NSLog (@"Starting new game!");
}


- (BOOL)textFieldShouldReturn:(UITextField *)sender {
    //gameCode= sender.text;
    //NSLog (@"%@", sender.text);
    NSLog (@"Before");
    [self performSegueWithIdentifier:@"HiderWait" sender:self];
    NSLog (@"After");
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    server = [[goSeekConnection alloc] init:self];
    [server subscribeToServerHider];
    [server requestRoomcode];
//    [server requestMarco];
//    [server requestCountDown];
    if (server == nil){
        NSLog(@"server is nil");
    }
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
   // _gameCodeField.delegate = self;
    
//    [gameCodeField addTarget:gameCodeField
//                  action:@selector(resignFirstResponder)
//        forControlEvents:UIControlEventEditingDidEndOnExit];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog (@"prepareSegue");
    
    SeekerWaitView *dest = (UIViewController *)segue.destinationViewController;
    
    dest->roomCode = self->gameCode;
    dest->server = server;
    
    
}



@end


//- (void)update:(CCTime)delta