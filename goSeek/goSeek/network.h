//
//  network.h
//  goSeek
//
//  Created by Nathan on 4/11/15.
//  Copyright (c) 2015 goSeek. All rights reserved.
//

#ifndef goSeek_network_h
#define goSeek_network_h

@class AVAudioPlayer;
@class UIViewController;
@class ViewController;
@class SeekerTimer;
@class SeekingView;

@interface goSeekConnection : NSObject<NSURLConnectionDelegate>
{
    NSMutableData *_responseData;
    NSString *_roomcode;
    ViewController *_mainView;
    @public NSString *_numPlayers;
    AVAudioPlayer* audioPlayer;

}
- (id)init:UIViewController;
- (void)subscribeToServerHider:(NSString*)roomCode;
- (void)subscribeToServerSeeker;
- (void)requestRoomcode;
- (void)requestMarco;
- (void)requestCountDown:(NSString*)rmCde ;
- (void)requestClose;
- (void)requestPlayerRemoved;
- (void)requestAddPlayer;
-(NSString*)getRoomCode;
-(void)setRoomCode:(NSString*)rmCde ;


@end


#endif
