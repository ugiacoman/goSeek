//
//  network.h
//  goSeek
//
//  Created by Nathan on 4/11/15.
//  Copyright (c) 2015 goSeek. All rights reserved.
//

#ifndef goSeek_network_h
#define goSeek_network_h

@class UIViewController;
@class ViewController;
@class SeekerTimer;
@class SeekingView;

@interface goSeekConnection : NSObject<NSURLConnectionDelegate>
{
    NSMutableData *_responseData;
    NSString *_roomcode;
    ViewController *_mainView;
}
- (id)init:UIViewController;
- (void)subscribeToServerHider;
- (void)subscribeToServerSeeker;
- (void)requestRoomcode;
- (void)requestMarco;
- (void)requestCountDown;
- (void)requestClose;

@end


#endif
