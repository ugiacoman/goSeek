//
//  SeekerWaitView.m
//  goSeek
//
//  Created by Corynne Dech on 4/11/15.
//  Copyright (c) 2015 goSeek. All rights reserved.
//

#import "SeekerWaitView.h"

@interface SeekerWaitView ()

@property (weak, nonatomic) IBOutlet UILabel *gameCode;

@end

@implementation SeekerWaitView
- (IBAction)playButton:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _gameCode.text = @"1111";
    NSLog (@"IN NEW VIEW");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end


//- (void)update:(CCTime)delta