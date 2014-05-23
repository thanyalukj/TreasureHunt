//
// Created by Thanyaluk Jirapech-umpai on 23/05/2014.
// Copyright (c) 2014 ThanyalukJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ESTBeacon;


@interface THBaseViewController : UIViewController
@property (nonatomic) NSUInteger majorId;
@property (nonatomic) NSUInteger minorId;
@property (weak, nonatomic) IBOutlet UIImageView *treasureImageView;
@property (weak, nonatomic) IBOutlet UIImageView *manImageView;
@property (weak, nonatomic) IBOutlet UILabel *roomClueLabel;
@property (weak, nonatomic) IBOutlet UILabel *specificLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;

@property (nonatomic, strong) UIAlertView *alert;

- (void)showNextScreen;

- (void)showAlert;

- (void)gotoNextScreen;
@end