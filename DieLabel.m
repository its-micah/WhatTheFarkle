//
//  DieLabel.m
//  WhatTheFarkle
//
//  Created by Micah Lanier on 3/19/15.
//  Copyright (c) 2015 Micah Lanier Design and Illustration. All rights reserved.
//

#import "DieLabel.h"
#import "ViewController.h"


@implementation DieLabel


- (IBAction)onTapped:(UITapGestureRecognizer *)sender {
    [self.delegate selectDie:self];
    self.backgroundColor = [UIColor colorWithWhite:0.780 alpha:1.000];
}


- (void)roll {
    int random = arc4random_uniform(6)+1;
    self.text = [NSString stringWithFormat:@"%i",random];
}


@end
