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
@property NSMutableArray *selectedDiceInTurn;


@end

int scoreKeeperInt = 0;
int one = 0;
int two = 0;
int three = 0;
int four = 0;
int five = 0;
int six = 0;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (DieLabel *label in self.labels) {
        label.delegate = self;
    }
    [self createView];
    [self callDynamics];
    self.dice = [NSMutableArray new];
    self.selectedDiceInTurn = [NSMutableArray new];

}

- (IBAction)onRollButtonPressed:(id)sender {
    for (DieLabel *label in self.labels) {
        [label roll];
        [self.selectedDiceInTurn removeAllObjects];
        one = 0;
        two = 0;
        three = 0;
        four = 0;
        five = 0;
        six = 0;
        [self.selectedDiceInTurn removeAllObjects];
    }

    [self callDynamics];
}

- (void)selectDie:(id)die {
    [self.labels removeObject:die];
    [self.dice addObject:die];
    [self.selectedDiceInTurn addObject:die];
    [self scoreMethod];
}

-(void)scoreMethod
{
    for (DieLabel *die in self.selectedDiceInTurn) {
        int intForSwitch = [die.text intValue];

        switch (intForSwitch) {
            case 1:
                one++;
                NSLog(@"only once");
                break;
            case 2:
                two++;
                break;
            case 3:
                three++;
                break;
            case 4:
                four++;
                break;
            case 5:
                five++;
                break;
            case 6:
                six++;
                break;
            default:NSLog(@"shid");
                break;
        }
    }
    if (one ==1 && two==1 && three==1 && four==1 && five==1 && six==1)
    {
        scoreKeeperInt += 1000;
        self.userScore.text = [NSString stringWithFormat:@"%i",scoreKeeperInt];
    }
    else if (one == 3)
    {
        scoreKeeperInt +=1000;
        self.userScore.text = [NSString stringWithFormat:@"%i",scoreKeeperInt];

    }
    else if (two ==3)
    {
        scoreKeeperInt +=200;
        self.userScore.text = [NSString stringWithFormat:@"%i",scoreKeeperInt];

    }
    else if (three ==3)
    {
        scoreKeeperInt +=300;
        self.userScore.text = [NSString stringWithFormat:@"%i",scoreKeeperInt];

    }
    else if (four ==3)
    {
        scoreKeeperInt +=400;
        self.userScore.text = [NSString stringWithFormat:@"%i",scoreKeeperInt];

    }
    else if (five ==3)
    {
        scoreKeeperInt +=500;
        self.userScore.text = [NSString stringWithFormat:@"%i",scoreKeeperInt];

    }
    else if (six ==3)
    {
        scoreKeeperInt +=600;
        self.userScore.text = [NSString stringWithFormat:@"%i",scoreKeeperInt];

    }

    else if (five==1)
    {
        scoreKeeperInt +=50;
        self.userScore.text = [NSString stringWithFormat:@"%i",scoreKeeperInt];

    }
    else if (one==1)
    {
        scoreKeeperInt +=100;
        self.userScore.text = [NSString stringWithFormat:@"%i",scoreKeeperInt];

    }
}

//- (void)selectDie:(id)die {
//    [self.labels removeObject:die];
//    [self.dice addObject:die];
//}

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
