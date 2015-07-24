//
//  ChallengeViewController.m
//  Veronica
//
//  Created by Dwayne Flaherty on 7/23/15.
//  Copyright (c) 2015 Willie Flaherty. All rights reserved.
//

#import "ChallengeViewController.h"
#import "KNClient.h"
#import "KNContainer.h"

@implementation ChallengeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadChallenge];
}

- (void)loadChallenge {
    if(!_kindredClient) _kindredClient = [KNContainer APIClient];
    
    [_kindredClient getChallengeWithCompletion:^(KNChallengeInfo *challenge, NSError *error) {
        if (error) {
            NSLog(@"Inside load challenge: %@", error);
        } else {
            [self displayChallenge:challenge];
        }
    }];
    
}

-(void) displayChallenge:(KNChallengeInfo *)challenge {
    [_challengeButton setTitle:challenge.challenge forState:UIControlStateNormal];
         
}

@end
