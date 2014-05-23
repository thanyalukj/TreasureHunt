//
//  THSecondViewController.m
//  TreasureHunt
//
//  Created by Thanyaluk Jirapech-umpai on 23/05/2014.
//  Copyright (c) 2014 ThanyalukJ. All rights reserved.
//

#import "THSecondViewController.h"
#import "THFinalViewController.h"

@interface THSecondViewController ()

@end

@implementation THSecondViewController

- (void)gotoNextScreen {
    [self performSegueWithIdentifier:@"gotoFinalView" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    THFinalViewController *vc = (THFinalViewController *)segue.destinationViewController;
    vc.majorId = 59274;
    vc.minorId = 30058;
}

@end
