//
// Created by Thanyaluk Jirapech-umpai on 23/05/2014.
// Copyright (c) 2014 ThanyalukJ. All rights reserved.
//

#import "THBaseViewController.h"
#import "ESTBeaconManager.h"
#import "ESTBeacon.h"
#import "THProximityStyle.h"
#import <AVFoundation/AVFoundation.h>

/*
 * Maximum distance (in meters) from beacon for which, the dot will be visible on screen.
 */
#define MAX_DISTANCE 5

@interface THBaseViewController () <ESTBeaconManagerDelegate>
@property (nonatomic, strong) ESTBeaconManager *beaconManager;
@property (nonatomic, strong) ESTBeaconRegion *beaconRegion;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) UIAlertView *alert;
@property (nonatomic, strong) UILabel *dotLabel;
@property (nonatomic) BOOL foundTreasure;
@end

@implementation THBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setupBeaconManager];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self stopTracking];
}

- (void)setupView {

}

- (void)setupBeaconManager {
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;

    self.beaconRegion = [[ESTBeaconRegion alloc] initWithProximityUUID:ESTIMOTE_PROXIMITY_UUID
                                                                 major:self.majorId
                                                                 minor:self.minorId
                                                            identifier:@"BeaconRegionIdentifier"];

//    self.beaconRegion.notifyOnEntry = YES;
//    self.beaconRegion.notifyOnExit = YES;

    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
//    [self.beaconManager startMonitoringForRegion:self.beaconRegion];
}

#pragma mark - ESTBeaconManager delegate
- (void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region {
    [self updateScreenWithBeacon:[beacons firstObject]];
}

- (void)updateScreenWithBeacon:(ESTBeacon *)beacon {
    THProximityStyle *style = [THProximityStyle styleForProximity:beacon.proximity];
    self.view.backgroundColor = style.colour;
    self.detailsLabel.text = [NSString stringWithFormat:@"%0.03f - %@",
                                                        [beacon.distance floatValue], style.title];;
    [self updatePositionForDistance:[beacon.distance floatValue]];
    if (!self.foundTreasure && beacon.proximity == CLProximityImmediate) {
        self.foundTreasure = YES;
        [self showNextScreen];
        [self showAlert];
        [self stopTracking];
    }
}

- (void)showNextScreen {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(gotoNextScreen)];
}

- (void)showAlert {
    if (!self.alert.visible) {
        self.alert = [[UIAlertView alloc] initWithTitle:@"Treasure Hunt"
                                                message:@"You've found the treasure"
                                               delegate:self
                                      cancelButtonTitle:@"Stay here"
                                      otherButtonTitles:@"Get next clue",nil];
        [self.alert show];
    }
}

- (void)stopTracking {
    [self.beaconManager stopRangingBeaconsInRegion:self.beaconRegion];
    [self.beaconManager stopMonitoringForRegion:self.beaconRegion];
}

- (CGFloat)topMargin {
    return self.treasureImageView.frame.origin.y + self.treasureImageView.frame.size.height + 5;
}

- (void)updatePositionForDistance:(float)distance {
    CGFloat step = (self.view.frame.size.height - [self topMargin]) / MAX_DISTANCE;
    CGFloat newY = [self topMargin] + (distance * step);
    [self.manImageView setCenter:CGPointMake(self.manImageView.center.x, newY)];
    [self.detailsLabel setCenter:CGPointMake(self.manImageView.center.x, newY + self.manImageView.frame.size.height + 5)];
}

//- (void)beaconManager:(ESTBeaconManager *)manager didEnterRegion:(ESTBeaconRegion *)region {
//    NSString *message = @"Approaching to right room";
//    NSLog(@"enter range");
//    self.audioPlayer = [self soundForNotification];
//    [self.audioPlayer play];
//
//    if (!self.alert.visible) {
//        self.alert = [[UIAlertView alloc] initWithTitle:@"Treasure Hunt"
//                                                message:message
//                                               delegate:nil
//                                      cancelButtonTitle:@"OK"
//                                      otherButtonTitles:nil];
//        [self.alert show];
//    }
//}
//
//- (void)beaconManager:(ESTBeaconManager *)manager didExitRegion:(ESTBeaconRegion *)region {
//    NSLog(@"exit range");
//}

- (AVAudioPlayer *)soundForNotification {
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/alarm.wav", [[NSBundle mainBundle] resourcePath]]];
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    audioPlayer.numberOfLoops = 1;
    return audioPlayer;
}

- (void)gotoNextScreen {

}
@end