//
//  THStartupViewController.m
//  TreasureHunt
//
//  Created by Thanyaluk Jirapech-umpai on 23/05/2014.
//  Copyright (c) 2014 ThanyalukJ. All rights reserved.
//

#import "THStartupViewController.h"
#import "THFirstViewController.h"

@interface THStartupViewController ()

@end

@implementation THStartupViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)gotoFirstView:(id)sender {
    [self performSegueWithIdentifier:@"gotoFirstView" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    THFirstViewController *vc = (THFirstViewController *)segue.destinationViewController;
    vc.majorId = 46071;
    vc.minorId = 50760;
}
@end
