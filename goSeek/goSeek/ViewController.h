//
//  ViewController.h
//  goSeek
//
//  Created by Corynne Dech on 4/11/15.
//  Copyright (c) 2015 goSeek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController //<UITextFieldDelegate>

//@property (retain, nonatomic) IBOutlet UITextField *gameCodeField;

@property (weak, nonatomic) IBOutlet NSString *gameCode;
@property (weak, nonatomic) IBOutlet UITextField *gameCodeField;

@end

