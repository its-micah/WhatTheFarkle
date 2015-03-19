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
//@property DieLabel *dieLabel;
@property IBOutletCollection(UILabel) NSMutableArray *labels;
@property NSMutableArray *dice;
@property DieLabel *pickedLabel;

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

- (void)findLabelUsingPoint:(CGPoint)point {
    for (DieLabel *label in self.labels) {
        if (CGRectContainsPoint(label.frame, point)) {
            self.pickedLabel = label;
        }
    }
}

- (void)labelTapped:(UITapGestureRecognizer *)sender {
    [self findLabelUsingPoint:[sender locationInView:self.view]];
    [self.labels removeObject:self.pickedLabel];
    [self.dice addObject:self.pickedLabel];
    NSLog(@"tapped");

}


@end
