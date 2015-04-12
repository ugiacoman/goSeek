//
//  ViewController.m
//  goSeek
//
//  Created by Corynne Dech on 4/11/15.
//  Copyright (c) 2015 goSeek. All rights reserved.
//

#import "ViewController.h"
#import "EventSource.h"
#import <AudioToolbox/AudioToolbox.h>
#import "network.h"
#import "SeekerWaitView.h"
#import "HiderWaitView.h"


@interface ViewController (){
    @public goSeekConnection *server;
    @public HiderWaitView *hiderWaitView;
    @public SeekerWaitView *seekerWaitView;
}

@property (strong, nonatomic) IBOutlet UIButton *startGame;
@property (strong, nonatomic) IBOutlet UITextField *gameCodeField;

@end

int gameCount = 0;


@implementation ViewController

- (IBAction)gameCodeField:(id)sender {
}


@synthesize gameCodeField;
- (IBAction)updateInput:(id)sender {
    
}
- (IBAction)textChanged:(id)sender {
    
    
}

- (SeekerWaitView*)getSeekerWaitView{
    return seekerWaitView;
}

- (HiderWaitView*)getHiderWaitView{
    return hiderWaitView;
}

- (SeekerTimer*)getSeekerTimer{
    return seekerWaitView->seekerTimer;
}

- (HiderTimer*)getHiderTimer{
    return hiderWaitView->hiderTimer;
}

- (SeekingView*)getSeekingView{
    return seekerWaitView->seekerTimer->seekingView;
}

- (HidingView*)getHidingView{
    return hiderWaitView->hiderTimer->hidingView;
}


- (IBAction)returnKeyButton:(id)sender {
    NSString *inputCode;
    inputCode = gameCodeField.text;
    NSLog (@"%@", inputCode);
    if(gameCodeField == nil){
        NSLog(@"FIELD NULL");
    }
    NSLog(@"returnkey");
    if(gameCount == 0){
        [server subscribeToServerHider:inputCode];
    }
    [sender resignFirstResponder];
    NSLog (@"Leaving main view as hider");
    gameCount++;
}
- (IBAction)startGame:(id)sender {
    [server requestRoomcode];
//    if(gameCount == 0){
//        [server subscribeToServerSeeker];
//    }
    NSLog (@"Starting new game!");
    gameCount++;
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
    UIImageView *animatedSplashScreen  = [[UIImageView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    [self.view addSubview:animatedSplashScreen];
    animatedSplashScreen.animationImages= [NSArray arrayWithObjects:[UIImage imageNamed:@"1.png"],[UIImage imageNamed:@"2.png"],[UIImage imageNamed:@"3.png"],[UIImage imageNamed:@"4.png"], nil];
    animatedSplashScreen.animationRepeatCount=5;
    animatedSplashScreen.animationDuration=.5;
    [animatedSplashScreen startAnimating];
    [self performSelector:@selector(hideSplash:) withObject:animatedSplashScreen afterDelay:5.0];
    
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    if (server == nil){
        server = [[goSeekConnection alloc] init:self];
    }
    
    
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

-(void)hideSplash:(id)object
{
    UIImageView *animatedImageview = (UIImageView *)object;
    [animatedImageview removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog (@"mainviewprepareSegue");
    
    
    seekerWaitView = (UIViewController *)segue.destinationViewController;
    seekerWaitView->server = server;
    
    
}



@end


//- (void)update:(CCTime)delta