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
    [self.delegate labelTapped:sender];
}


- (void)roll {
    //[self.delegate roll];

    int random = arc4random_uniform(6) +1;
    self.text = [NSString stringWithFormat:@"%i",random];


}


@end
