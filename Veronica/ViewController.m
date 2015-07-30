//
//  ViewController.m
//  Veronica
//
//  Created by Dwayne Flaherty on 7/11/15.
//  Copyright (c) 2015 Willie Flaherty. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //UIColor * blueColor = [UIColor colorWithRed:0.094 green:0.557 blue:0.749 alpha:1]; /*#188ebf*/
    UIColor * blueColor = [UIColor colorWithRed:0.212 green:0.69 blue:0.933 alpha:1]; /*#36b0ee*/
    self.view.backgroundColor = blueColor;
    
    //we should check if we have access to user location here
    //if we have access:
    //  we should check that their current location is equal to our cached location
    //  if it's not, update the cached location
    //if we don't have access:
    //ask for access and make the login button say to give us access
    //we should probably put this in a view will appear ?
    
}
- (IBAction)test:(id)sender {
    NSLog(@"Pressed");
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
