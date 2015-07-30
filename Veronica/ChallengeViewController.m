//
//  ChallengeViewController.m
//  Veronica
//
//  Created by Dwayne Flaherty on 7/23/15.
//  Copyright (c) 2015 Willie Flaherty. All rights reserved.
//

#import <MobileCoreServices/UTCoreTypes.h>
#import "ChallengeViewController.h"
#import "KNClient.h"
#import "KNContainer.h"
#import "KNTypes.h"
#import "KNStorage.h"
#import "KNConfiguration.h"

@implementation ChallengeViewController{
    KNClient *_kindredClient;
    KNInstagramService *_instagramService;
    KNStorage *_storage;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //initialize my services
    _kindredClient = [KNContainer APIClient];
    _instagramService = [KNContainer instagramService];
    _storage = [KNContainer storage];
    
    //check if this is a new user
    if([_storage objectForKey:KNUserInfoKey] == nil){
        [self saveUser];
    }
    //load the current challenge
    [self loadChallenge];

}

- (void) saveUser {
    [_instagramService getInstagramUserInfoWithCompletion:^(KNInstagramUserInfo *userInfo, NSError *error) {
        
        [_kindredClient storeUserInfo:userInfo withCompletion: ^(KNUserInfo *currInfo, NSError *error) {
        //nothing needs to happen here atm should do some error handling just in case
        }];
        
    }];
}
- (void)loadChallenge {    
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

- (IBAction)completeChallenge:(id)sender {
   // when they press the challenge button
    //we should open the camera
    self.cameraUI = [[UIImagePickerController alloc] init];
    self.cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.cameraUI.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    self.cameraUI.mediaTypes =  [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    self.cameraUI.allowsEditing = NO;
    self.cameraUI.delegate = self;
    
    [self presentViewController:self.cameraUI animated:YES completion:nil];
    
    
}

#pragma mark ui image picker delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    //INVESTIGATE: http://stackoverflow.com/questions/12355589/uiimagepickercontrolleroriginalimage-vs-original-asset-data
    UIImage *photo = info[@"UIImagePickerControllerOriginalImage"];
    
    //start a loading screen here?
    [_kindredClient storePhoto:photo withCompletion: ^(KNPhotoInfo *retPhoto, NSError *error) {
        
        
    }];
    
    [picker dismissViewControllerAnimated:YES completion:^(void){
        
    }];
    
}

@end
