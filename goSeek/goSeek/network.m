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

- (void)subscribeToServerHider :(NSString*) roomCode{
    NSLog(@"ROOMCODE in subscribe: %@", roomCode);
    _roomcode = roomCode;
    NSMutableString *requestURL = [NSMutableString stringWithString:@"http://45.55.188.238:5000/polo?roomcode="];
    NSLog(@"requrl: %@", requestURL);
    [requestURL appendString:(NSString*)roomCode];
    NSLog(@"requrl: %@", requestURL);
    NSURL *serverURL = [NSURL URLWithString:requestURL];
    
    EventSource *sourceCountDown = [EventSource eventSourceWithURL:serverURL];
    [sourceCountDown addEventListener:@"COUNTDOWN" handler:^(Event *e) {
        NSLog(@"%@: %@", e.event, e.data);
        @try{
            HiderTimer *hiderTimer = [_mainView getHiderTimer];
            [hiderTimer updateCountdown :e.data];
        }
        @catch(NSException* e){
            HiderWaitView *hiderWaitView = [_mainView getHiderWaitView];
            [hiderWaitView performSegueWithIdentifier:@"startHiderTimer" sender:hiderWaitView];
        }
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
    
    EventSource *sourcePlayersAdded = [EventSource eventSourceWithURL:serverURL];
    [sourcePlayersAdded addEventListener:@"ADD_PLAYER" handler:^(Event *e) {
        NSLog(@"%@: %@", e.event, e.data);
        
        @try {
            HiderWaitView *hiderWaitView = [_mainView getHiderWaitView];
            [hiderWaitView updatePlayersLeft :e.data];
//            
//            HidingView *hidingView = [_mainView getHidingView];
//            [hidingView updatePlayersLeft :e.data];
        }
        @catch (NSException *exception) {
        }

    }];
    
    EventSource *sourcePlayersRemoved = [EventSource eventSourceWithURL:serverURL];
    [sourcePlayersRemoved addEventListener:@"REMOVE_PLAYER" handler:^(Event *e) {
        NSLog(@"%@: %@", e.event, e.data);
        
        @try {
            HiderWaitView *hiderWaitView2 = [_mainView getHiderWaitView];
            [hiderWaitView2 updatePlayersLeft :e.data];
            
            HidingView *hidingView2 = [_mainView getHidingView];
            [hidingView2 updatePlayersLeft :e.data];
        }
        @catch (NSException *exception) {}
        
    }];
    
    [self requestAddPlayer];
    
    
    
}

- (void)subscribeToServerSeeker{
    NSMutableString *requestURL = [NSMutableString stringWithString:@"http://45.55.188.238:5000/seeker?roomcode="];
    [requestURL appendString:_roomcode];
    NSURL *serverURL = [NSURL URLWithString:requestURL];
    
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
    
    EventSource *sourcePlayersAdded = [EventSource eventSourceWithURL:serverURL];
    [sourcePlayersAdded addEventListener:@"ADD_PLAYER" handler:^(Event *e) {
        NSLog(@"%@: %@", e.event, e.data);
        
        @try {
            SeekerWaitView *seekerWaitView = [_mainView getSeekerWaitView];
            [seekerWaitView updatePlayersLeft :e.data];
        }
        @catch (NSException *exception) {}
    }];
    
    EventSource *sourcePlayersRemoved = [EventSource eventSourceWithURL:serverURL];
    [sourcePlayersRemoved addEventListener:@"REMOVE_PLAYER" handler:^(Event *e) {
        NSLog(@"%@: %@", e.event, e.data);
        @try {
            SeekingView *seekingView2 = [_mainView getSeekingView];
            [seekingView2 updatePlayersLeft :e.data];
        }
        @catch (NSException *exception) {}
    }];
    
}

- (void)requestAddPlayer{
    // Requests server to send out new roomcode
    // picked up by subscribers, not this method
    NSMutableString *requestURL = [NSMutableString stringWithString:@"http://45.55.188.238:5000/add_player?roomcode="];
    [requestURL appendString:_roomcode];
    NSURLRequest *requestAddPlayer = [NSURLRequest requestWithURL:[NSURL URLWithString:requestURL]];
    
    
    NSURLConnection *connAddPlayer = [[NSURLConnection alloc] initWithRequest:requestAddPlayer delegate:self];
}


- (void)requestPlayerRemoved{
    // Requests server to send out new roomcode
    // picked up by subscribers, not this method
    NSMutableString *requestURL = [NSMutableString stringWithString:@"http://45.55.188.238:5000/remove_player?roomcode="];
    [requestURL appendString:_roomcode];
    NSURLRequest *requestRemovePlayer = [NSURLRequest requestWithURL:[NSURL URLWithString:requestURL]];
    
    
    NSURLConnection *connRemovePlayer = [[NSURLConnection alloc] initWithRequest:requestRemovePlayer delegate:self];
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
    NSMutableString *requestURL = [NSMutableString stringWithString:@"http://45.55.188.238:5000/marco?roomcode="];
    [requestURL appendString:_roomcode];
    NSURLRequest *requestMarco = [NSURLRequest requestWithURL:[NSURL URLWithString:requestURL]];
    
    NSURLConnection *connMarco = [[NSURLConnection alloc] initWithRequest:requestMarco delegate:self];
}

- (void)requestCountDown{
    // Request CountDown, time determined by server
    // Server will send out time updates every second to
    // all subscribers
    NSMutableString *requestURL = [NSMutableString stringWithString:@"http://45.55.188.238:5000/countdown?roomcode="];
    [requestURL appendString:_roomcode];
    NSURLRequest *requestCountDown = [NSURLRequest requestWithURL:[NSURL URLWithString:requestURL]];
    
    NSURLConnection *connCountDown = [[NSURLConnection alloc] initWithRequest:requestCountDown delegate:self];
}

- (void)requestClose{
    // Request server to close connections
    NSMutableString *requestURL = [NSMutableString stringWithString:@"http://45.55.188.238:5000/close?roomcode="];
    [requestURL appendString:_roomcode];
    NSURLRequest *requestClose = [NSURLRequest requestWithURL:[NSURL URLWithString:requestURL]];
    
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
        NSLog(@"%@", _roomcode);
        @try{
            [self subscribeToServerSeeker];
        }
        @catch (NSException * e) {
            NSLog(@"Exception: %@", e);
        }
        @try{
            SeekerWaitView *seekerWaitView3 = [_mainView getSeekerWaitView];
            [seekerWaitView3 updateRoomCode :_roomcode];
        }
        @catch (NSException * e) {
             NSLog(@"Exception: %@", e);
        }
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