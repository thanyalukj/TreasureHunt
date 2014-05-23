//
// Created by Thanyaluk Jirapech-umpai on 23/05/2014.
// Copyright (c) 2014 ThanyalukJ. All rights reserved.
//

#import "THFinalViewController.h"


@implementation THFinalViewController {

}

- (void)showAlert {
    if (!self.alert.visible) {
        self.alert = [[UIAlertView alloc] initWithTitle:@"Treasure Hunt"
                                                message:@"Congratulations! You've won!"
                                               delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
        [self.alert show];
    }
}

- (void)showNextScreen {

}

@end