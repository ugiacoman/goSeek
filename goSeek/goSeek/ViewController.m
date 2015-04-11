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




@implementation ViewController
- (IBAction)gameCodeField:(id)sender {
}


IBOutlet UIButton *newCode;
@synthesize gameCodeField, gameCode;
- (IBAction)updateInput:(id)sender {
    
}
- (IBAction)textChanged:(id)sender {
    
    
}

- (IBAction)returnKeyButton:(id)sender {
    gameCodeField.text = @"HELLOOO";
    NSLog (@"%@", gameCodeField.text);
    if(gameCodeField == nil){
        NSLog(@"FIELD NULL");
    }
    NSLog(@"returnkey");
        [sender resignFirstResponder];
}

- (IBAction)newGame:(id)sender {
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
    // Do any additional setup after loading the view, typically from a nib.
    
   // _gameCodeField.delegate = self;
    
    [gameCodeField addTarget:gameCodeField
                  action:@selector(resignFirstResponder)
        forControlEvents:UIControlEventEditingDidEndOnExit];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *code = gameCodeField.text;
    int cod = [[gameCodeField text] intValue];
//    gameCode = (UITextField *)sender.text;
    NSLog (@"%@", gameCodeField.text);
    NSLog (@"prepareSegue");
}



@end


//- (void)update:(CCTime)delta