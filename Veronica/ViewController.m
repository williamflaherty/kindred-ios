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
