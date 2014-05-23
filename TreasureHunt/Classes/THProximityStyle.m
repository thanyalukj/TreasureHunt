//
// Created by Thanyaluk Jirapech-umpai on 23/05/2014.
// Copyright (c) 2014 ThanyalukJ. All rights reserved.
//

#import "THProximityStyle.h"


@implementation THProximityStyle {

}

+ (THProximityStyle *)styleForProximity:(CLProximity)proximity {
    THProximityStyle *style = [[THProximityStyle alloc] init];
    switch (proximity) {
        case CLProximityFar:
            style.title = @"Too far";
            style.colour = [UIColor blueColor];
            break;
        case CLProximityNear:
            style.title = @"Getting Closer";
            style.colour = [UIColor yellowColor];
            break;
        case CLProximityImmediate:
            style.title = @"Here it is!";
            style.colour = [UIColor greenColor];
            break;
        default:
            style.title = @"In the middle of nowhere";
            style.colour = [UIColor whiteColor];
    }
    return style;
}

@end