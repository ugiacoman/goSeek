//
//  network.m
//  goSeek
//
//  Created by Nathan on 4/11/15.
//  Copyright (c) 2015 goSeek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "network.h"
#import "EventSource.h"
#import <AudioToolbox/AudioToolbox.h>
#import "SeekerTimer.h"
#import "SeekingView.h"
#import "SeekerWaitView.h"
#import "HiderTimer.h"
#import "HiderWaitView.h"
#import "HidingView.h"
#import "ViewController.h"

@interface goSeekConnection ()

@end


@implementation goSeekConnection

- (id)init:(ViewController *)mainView{
    _mainView = mainView;
    return self;
}

- (void)subscribeToServerHider {
    
    NSURL *serverURL = [NSURL URLWithString:@"http://45.55.188.238:5000/polo"];
    
    EventSource *sourceCountDown = [EventSource eventSourceWithURL:serverURL];
    [sourceCountDown addEventListener:@"COUNTDOWN" handler:^(Event *e) {
        NSLog(@"%@: %@", e.event, e.data);
        
        HiderTimer *hiderTimer = [_mainView getHiderTimer];
        [hiderTimer updateCountdown :e.data];
    }];
    
    EventSource *sourceMarco = [EventSource eventSourceWithURL:serverURL];
    [sourceMarco addEventListener:@"MARCO" handler:^(Event *e) {
        NSLog(@"%@: %@", e.event, e.data);
        AudioServicesPlaySystemSound (1005);
        
    }];

    EventSource *sourceClose = [EventSource eventSourceWithURL:serverURL];
    [sourceClose addEventListener:@"CLOSE" handler:^(Event *e) {
        NSLog(@"%@: %@", e.event, e.data);
        
        //Corynne tells _mainView end personal game
    }];
    
    [self requestAddPlayer];
    
    
    
}

- (void)subscribeToServerSeeker{
    NSURL *serverURL = [NSURL URLWithString:@"http://45.55.188.238:5000/seeker"];
    
    EventSource *sourceCountdown = [EventSource eventSourceWithURL:serverURL];
    [sourceCountdown addEventListener:@"COUNTDOWN" handler:^(Event *e) {
        NSLog(@"%@: %@", e.event, e.data);
        
        SeekerTimer *seekerTimer = [_mainView getSeekerTimer];
        [seekerTimer updateCountdown :e.data];
        
    }];
    
    EventSource *sourceClose = [EventSource eventSourceWithURL:serverURL];
    [sourceClose addEventListener:@"CLOSE" handler:^(Event *e) {
        NSLog(@"%@: %@", e.event, e.data);
        
        //Corynne tells _mainView end personal game
    }];
    
    EventSource *sourcePlayersLeft = [EventSource eventSourceWithURL:serverURL];
    [sourceClose addEventListener:@"ADD_PLAYER" handler:^(Event *e) {
        NSLog(@"%@: %@", e.event, e.data);
        
        SeekingView *seekingView = [_mainView getSeekingView];
        [seekingView updatePlayersLeft :e.data];
    }];
    
}

- (void)requestAddPlayer{
    // Requests server to send out new roomcode
    // picked up by subscribers, not this method
    NSURLRequest *requestAddPlayer = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://45.55.188.238:5000/add_player"]];
    
    
    NSURLConnection *connAddPlayer = [[NSURLConnection alloc] initWithRequest:requestAddPlayer delegate:self];
}


- (void)requestRoomcode{
    // Requests server to send out new roomcode
    // picked up by subscribers, not this method
    NSURLRequest *requestRoomCode = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://45.55.188.238:5000/roomcode"]];
    
    
    NSURLConnection *connRoomCode = [[NSURLConnection alloc] initWithRequest:requestRoomCode delegate:self];
}

- (void)requestMarco{
    // Requests server to send out marco
    // picked up by subscribers
    NSURLRequest *requestMarco = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://45.55.188.238:5000/marco"]];
    
    NSURLConnection *connMarco = [[NSURLConnection alloc] initWithRequest:requestMarco delegate:self];
}

- (void)requestCountDown{
    // Request CountDown, time determined by server
    // Server will send out time updates every second to
    // all subscribers
    
    NSURLRequest *requestCountDown = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://45.55.188.238:5000/countdown"]];
    
    NSURLConnection *connCountDown = [[NSURLConnection alloc] initWithRequest:requestCountDown delegate:self];
}

- (void)requestClose{
    // Request server to close connections
    NSURLRequest *requestClose = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://45.55.188.238:5000/close"]];
    
    NSURLConnection *connClose = [[NSURLConnection alloc] initWithRequest:requestClose delegate:self];
    
}


#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _responseData = [[NSMutableData alloc] init];
}



- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_responseData appendData:data];
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSString* temp = [json objectForKey:@"roomcode"];
    if (temp != nil){
        _roomcode = temp;
        NSLog(_roomcode);
    }

    @try{
        SeekerWaitView *seekerWaitView = [_mainView getSeekerWaitView];
        [seekerWaitView updateRoomCode :_roomcode];
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
    }
    
    
    
    NSLog(@"\nDid recieve data\n");
    
}




- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //NSLog(@"loading finished\n");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"connection failed\n");
}

@end