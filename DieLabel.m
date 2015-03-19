//
//  DieLabel.m
//  WhatTheFarkle
//
//  Created by Micah Lanier on 3/19/15.
//  Copyright (c) 2015 Micah Lanier Design and Illustration. All rights reserved.
//

#import "DieLabel.h"

@implementation DieLabel


- (IBAction)onTapped:(UITapGestureRecognizer *)sender {
    [self.delegate roll];
}


- (void)roll {
    //int random = arc4random_uniform(6);
    //label.text = [NSString stringWithFormat:@"%i", random];
}


@end
