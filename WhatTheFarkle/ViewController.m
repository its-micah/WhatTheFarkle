//
//  ViewController.m
//  WhatTheFarkle
//
//  Created by Micah Lanier on 3/19/15.
//  Copyright (c) 2015 Micah Lanier Design and Illustration. All rights reserved.
//

#import "ViewController.h"
#import "DieLabel.h"

@interface ViewController () <DieLabelDelegate>
@property DieLabel *dieLabel;
@property IBOutletCollection(UILabel) NSArray *labels;
@property NSMutableArray *dice;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dieLabel.delegate = self;
}

- (IBAction)onRollButtonPressed:(id)sender {

    for (UILabel *label in self.labels) {
        int random = arc4random_uniform(6) +1;
        label.text = [NSString stringWithFormat:@"%i",random];

    }
}


@end
