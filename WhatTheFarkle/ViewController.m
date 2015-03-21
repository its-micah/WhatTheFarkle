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
@property IBOutletCollection(UILabel) NSMutableArray *labels;
@property NSMutableArray *dice;
@property DieLabel *pickedLabel;
@property (weak, nonatomic) IBOutlet UILabel *userScore;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (DieLabel *label in self.labels) {
        label.delegate = self;
    }
}

- (IBAction)onRollButtonPressed:(id)sender {
    for (DieLabel *label in self.labels) {
        [label roll];
    }
}

- (void)selectDie:(id)die {
    [self.labels removeObject:die];
    [self.dice addObject:die];
}




@end
