//
//  ViewController.m
//  MDMAlertView
//
//  Created by Alekseenko Oleg on 28.08.14.
//  Copyright (c) 2014 alekoleg. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
            

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    

}
- (IBAction)showAlert:(id)sender {
    MDMButtonsAlertView *alert = [[MDMButtonsAlertView alloc] initWithTitle:@"Alert Title" cancelButton:@"Cancel" otherButtons:@[@"First other button", @"Second other button"] onCancellClicked:NULL onOtherClicked:NULL];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
