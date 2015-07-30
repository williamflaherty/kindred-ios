//
//  InstagramLoginViewController.m
//  Veronica
//
//  Created by Dwayne Flaherty on 7/20/15.
//  Copyright (c) 2015 Willie Flaherty. All rights reserved.
//

#import "InstagramLoginViewController.h"
#import "KNInstagramService.h"
#import "KNContainer.h"

@interface InstagramLoginViewController ()

@end

@implementation InstagramLoginViewController{
    KNInstagramService *_instagramService;
    KNClient *_kindredClient;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (_instagramService == nil) {
        _instagramService = [KNContainer instagramService];
    }
    
    self.webView.delegate = self;
    
    NSURLRequest *authenticationRequest = [_instagramService getAuthenticationRequest];
    [self.webView loadRequest:authenticationRequest];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    BOOL permissionGranted;
    
    if ([_instagramService tryParseRedirectRequest:request accessGranted:&permissionGranted]) {
        // UIWebView will call didFailLoadWithError: when this method returns NO
        self.webView.delegate = nil;
        
        if (permissionGranted) {
            
            [self transitionToChallenge];
        } else {
            // TODO: show alert message
            [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        }
        
        return NO;
    }
    
    return YES;
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"WebView failed to load: %@", error);
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)transitionToChallenge
{
    [self performSegueWithIdentifier:@"Challenge" sender:nil];
}

@end
