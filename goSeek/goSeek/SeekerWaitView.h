//
//  SeekerWaitView.h
//  goSeek
//
//  Created by Corynne Dech on 4/11/15.
//  Copyright (c) 2015 goSeek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeekerWaitView : UIViewController{
        @public NSString *roomCode;
        @public NSString *countdown;
        @public goSeekConnection *server;
}

@end

