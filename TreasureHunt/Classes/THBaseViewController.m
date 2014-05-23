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
#define MAX_DISTANCE 20
#define TOP_MARGIN   150

@interface THBaseViewController () <ESTBeaconManagerDelegate>
@property (nonatomic, strong) ESTBeaconManager *beaconManager;
@property (nonatomic, strong) ESTBeaconRegion *beaconRegion;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) UIAlertView *alert;
@property (nonatomic, strong) UIImageView *dotImageView;
@property (nonatomic, strong) UILabel *dotLabel;
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
    [self.beaconManager stopRangingBeaconsInRegion:self.beaconRegion];
    [self.beaconManager stopMonitoringForRegion:self.beaconRegion];
}

- (void)setupView {
    self.view.backgroundColor = [UIColor yellowColor];

    UIImageView *beaconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"treasure"]];
    [beaconImageView setCenter:CGPointMake(self.view.center.x, 100)];
    [self.view addSubview:beaconImageView];

    self.dotImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"man"]];
    [self.dotImageView setCenter:self.view.center];
    [self.view addSubview:self.dotImageView];

    self.dotLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
    [self.dotLabel setCenter:self.view.center];
    [self.view addSubview:self.dotLabel];
}

- (void)setupBeaconManager {
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;

    self.beaconRegion = [[ESTBeaconRegion alloc] initWithProximityUUID:ESTIMOTE_PROXIMITY_UUID
                                                                 major:self.majorId
                                                                 minor:self.minorId
                                                            identifier:@"BeaconRegionIdentifier"];

    self.beaconRegion.notifyOnEntry = YES;
    self.beaconRegion.notifyOnExit = YES;

    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
    [self.beaconManager startMonitoringForRegion:self.beaconRegion];
}

#pragma mark - ESTBeaconManager delegate
- (void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region {
    [self updateScreenWithBeacon:[beacons firstObject]];
}

- (void)updateScreenWithBeacon:(ESTBeacon *)beacon {
    THProximityStyle *style = [THProximityStyle styleForProximity:beacon.proximity];
    self.view.backgroundColor = style.colour;
    NSString *desc = [NSString stringWithFormat:@"%0.03f - %@",
                    [beacon.distance floatValue], style.title];
    self.dotLabel.text = desc;
    [self updatePositionForDistance:[beacon.distance floatValue]];
    if (beacon.proximity == CLProximityImmediate) {
        [self showAlert];
    }
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

- (void)updatePositionForDistance:(float)distance {
    float step = (self.view.frame.size.height - TOP_MARGIN) / MAX_DISTANCE;
    int newY = TOP_MARGIN + (distance * step);
    [self.dotImageView setCenter:CGPointMake(self.dotImageView.center.x, newY)];
    [self.dotLabel setCenter:CGPointMake(self.dotImageView.center.x, newY + self.dotImageView.frame.size.height + 5)];
}

- (void)beaconManager:(ESTBeaconManager *)manager didEnterRegion:(ESTBeaconRegion *)region {
    NSString *message = @"Approaching to a treasure";
    UILocalNotification *notification = [UILocalNotification new];
    notification.alertBody = @"Warning, cyclist approaching";
    notification.soundName = UILocalNotificationDefaultSoundName;

    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    NSLog(@"enter");

    self.audioPlayer = [self soundForNotification];
    [self.audioPlayer play];

    if (!self.alert.visible) {
        self.alert = [[UIAlertView alloc] initWithTitle:@"Treasure Hunt"
                                                message:message
                                               delegate:nil
                                      cancelButtonTitle:@"Get next clue"
                                      otherButtonTitles:nil];
        [self.alert show];
    }
}

- (void)beaconManager:(ESTBeaconManager *)manager didExitRegion:(ESTBeaconRegion *)region {
    NSString *message = @"You are too far away from a treasure";
    UILocalNotification *notification = [UILocalNotification new];
    notification.alertBody = message;

    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    NSLog(@"exit");

    if (!self.alert.visible) {
        self.alert = [[UIAlertView alloc] initWithTitle:@"Treasure Hunt"
                                                message:message
                                               delegate:nil
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
        [self.alert show];
    }
}

- (AVAudioPlayer *)soundForNotification {
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/alarm.wav", [[NSBundle mainBundle] resourcePath]]];
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    audioPlayer.numberOfLoops = 1;
    return audioPlayer;
}

@end