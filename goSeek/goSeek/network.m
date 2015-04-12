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
#import "ViewController.h"

@interface goSeekConnection ()

@end


@implementation goSeekConnection

- (id)init:(ViewController *)mainView{
    _mainView = mainView;
    return self;
}

- (void)subscribeToServerHider {
    
    NSLog(@"Hello World!");
    
    NSURL *serverURL = [NSURL URLWithString:@"http://45.55.188.238:5000/polo"];
    
    EventSource *sourceCountDown = [EventSource eventSourceWithURL:serverURL];
    [sourceCountDown addEventListener:@"COUNTDOWN" handler:^(Event *e) {
        NSLog(@"%@: %@", e.event, e.data);
        
        //Corynne tells _mainView to do something with Countdown data
        //Corynne tells _mainView to do something with _roomcode
        SeekerTimer *seekerTimer = [_mainView getSeekerTimer];
        [seekerTimer updateCountdown :e.data];
        
        //e.data will be strings that represent the number of seconds
        //remaining
        
    }];
    
    EventSource *sourceMarco = [EventSource eventSourceWithURL:serverURL];
    [sourceMarco addEventListener:@"MARCO" handler:^(Event *e) {
        NSLog(@"%@: %@", e.event, e.data);
        AudioServicesPlaySystemSound (1005);
        
        //Corynne tells _mainView to do something with marco data
        //e.data is actually empty, you just need to tell _mainView to make a chirp
        
    }];

    EventSource *sourceClose = [EventSource eventSourceWithURL:serverURL];
    [sourceClose addEventListener:@"CLOSE" handler:^(Event *e) {
        NSLog(@"%@: %@", e.event, e.data);
        
        //Corynne tells _mainView end personal game
    }];
    
}

- (void)subscribeToServerSeeker{
    NSURL *serverURL = [NSURL URLWithString:@"http://45.55.188.238:5000/seeker"];
    
    EventSource *sourceCountdown = [EventSource eventSourceWithURL:serverURL];
    [sourceCountdown addEventListener:@"COUNTDOWN" handler:^(Event *e) {
        NSLog(@"%@: %@", e.event, e.data);
    }];
    
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

    
    //Corynne tells _mainView to do something with _roomcode
    ViewController *view = (ViewController *)_mainView;
    view->gameCode = _roomcode;
    
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