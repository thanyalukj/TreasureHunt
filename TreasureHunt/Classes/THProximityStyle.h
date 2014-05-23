//
// Created by Thanyaluk Jirapech-umpai on 23/05/2014.
// Copyright (c) 2014 ThanyalukJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface THProximityStyle : NSObject
@property (nonatomic) NSString *title;
@property (nonatomic) UIColor *colour;

+ (THProximityStyle *)styleForProximity:(CLProximity)proximity;
@end