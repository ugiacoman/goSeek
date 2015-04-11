//
//  ViewController.m
//  goSeek
//
//  Created by Corynne Dech on 4/11/15.
//  Copyright (c) 2015 goSeek. All rights reserved.
//

#import "ViewController.h"
#import "SeekerWaitView.h"

@interface ViewController ()

@end

UIButton *newCode;
UITextField *gameCodeField;

@implementation ViewController

- (IBAction)returnKeyButton:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)newGame:(id)sender {
     NSLog (@"Starting new game!");
}

- (IBAction)gameCodeField:(UITextField *)sender {
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)sender {
    NSLog (@"Text field should return");
    [self performSegueWithIdentifier:@"HiderWait" sender:self];
    NSLog (@"After");
    return YES;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    CGRect frameRect = gameCodeField.frame;
    frameRect.size.height = 100;
    gameCodeField.frame = frameRect;
    
    
    [gameCodeField addTarget:gameCodeField
                  action:@selector(resignFirstResponder)
        forControlEvents:UIControlEventEditingDidEndOnExit];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end


//- (void)update:(CCTime)delta