//
//  ViewController.h
//  goSeek
//
//  Created by Corynne Dech on 4/11/15.
//  Copyright (c) 2015 goSeek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "network.h"

@interface ViewController : UIViewController{
    @public NSString *gameCode;
    @public goSeekConnection *server;
}
@end

