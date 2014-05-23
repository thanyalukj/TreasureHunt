//
// Created by Thanyaluk Jirapech-umpai on 23/05/2014.
// Copyright (c) 2014 ThanyalukJ. All rights reserved.
//

#import "THFirstViewController.h"
#import "THSecondViewController.h"

@interface THFirstViewController ()
@end

@implementation THFirstViewController {

}

- (void)gotoNextScreen {
    [self performSegueWithIdentifier:@"gotoSecondView" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    THSecondViewController *vc = (THSecondViewController *)segue.destinationViewController;
    vc.majorId = 46071;
    vc.minorId = 50760;
}

@end