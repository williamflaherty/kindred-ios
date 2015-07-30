//
//  ChallengeViewController.h
//  Veronica
//
//  Created by Dwayne Flaherty on 7/23/15.
//  Copyright (c) 2015 Willie Flaherty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KNClient.h"

@interface ChallengeViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *challengeButton;
@property (strong, nonatomic) IBOutlet UIImagePickerController *cameraUI;

@end
