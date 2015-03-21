//
//  ViewController.m
//  WhatTheFarkle
//
//  Created by Micah Lanier on 3/19/15.
//  Copyright (c) 2015 Micah Lanier Design and Illustration. All rights reserved.
//

#import "ViewController.h"
#import "DieLabel.h"

@interface ViewController () <DieLabelDelegate, UICollisionBehaviorDelegate>
@property IBOutletCollection(UILabel) NSMutableArray *labels;
@property NSMutableArray *dice;
@property DieLabel *pickedLabel;
@property (weak, nonatomic) IBOutlet UILabel *userScore;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property UIView *dieContainer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (DieLabel *label in self.labels) {
        label.delegate = self;
    }
    [self createView];
    [self callDynamics];
    self.dice = [NSMutableArray new];
}

- (IBAction)onRollButtonPressed:(id)sender {
    for (DieLabel *label in self.labels) {
        [label roll];
    }
    UIEvent *shake;

    [self motionBegan:UIEventSubtypeMotionShake withEvent:shake];
    [self callDynamics];
}

- (void)selectDie:(id)die {
    [self.labels removeObject:die];
    [self.dice addObject:die];
}

- (void)createView {
    self.dieContainer = [[UIView alloc] initWithFrame:CGRectMake(37, 200, 300, 300)];
    self.dieContainer.backgroundColor = [UIColor colorWithRed:0.260 green:0.584 blue:0.708 alpha:1.000];
    [self.view addSubview:self.dieContainer];
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier {
    identifier = @"top";
    identifier = @"bottom";
    identifier = @"leftSide";
    identifier = @"rightSide";
    [behavior setCollisionMode:UICollisionBehaviorModeEverything];
}

- (void)callDynamics {


    [self.dieContainer addSubview:[self.labels objectAtIndex:0]];
    [self.dieContainer addSubview:[self.labels objectAtIndex:1]];
    [self.dieContainer addSubview:[self.labels objectAtIndex:2]];
    [self.dieContainer addSubview:[self.labels objectAtIndex:3]];
    [self.dieContainer addSubview:[self.labels objectAtIndex:4]];
    [self.dieContainer addSubview:[self.labels objectAtIndex:5]];


    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];


    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:self.labels];
    itemBehavior.elasticity = 0.894;
    itemBehavior.angularResistance = 0.4;
    itemBehavior.friction = 0.2;
    itemBehavior.density = 0.5;


    UIGravityBehavior *gravityBehavior =[[UIGravityBehavior alloc] initWithItems:self.labels];

    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:self.labels];
    collisionBehavior.collisionDelegate = self;
    [collisionBehavior addBoundaryWithIdentifier:@"top" fromPoint:CGPointMake(37, 160) toPoint:CGPointMake(337, 160)];
    [collisionBehavior addBoundaryWithIdentifier:@"bottom" fromPoint:CGPointMake(37, 500) toPoint:CGPointMake(337, 500)];
    [collisionBehavior addBoundaryWithIdentifier:@"leftSide" fromPoint:CGPointMake(37, 200) toPoint:CGPointMake(37, 500)];
    [collisionBehavior addBoundaryWithIdentifier:@"rightSide" fromPoint:CGPointMake(337, 200) toPoint:CGPointMake(337, 500)];
    [collisionBehavior setCollisionMode:UICollisionBehaviorModeEverything];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;

    [self.animator addBehavior:itemBehavior];
    [self.animator addBehavior:gravityBehavior];
    [self.animator addBehavior:collisionBehavior];

}




@end
