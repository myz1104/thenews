//
//  TNLaunchViewController.m
//  thenews
//
//  Created by Tosin Afolabi on 03/02/2014.
//  Copyright (c) 2014 Tosin Afolabi. All rights reserved.
//

#import "TNLaunchViewController.h"
#import "TNSignupViewController.h"
#import "TNLoginViewController.h"
#import "TNHomeViewController.h"
#import "UIColor+TNColors.h"
#import "TNButton.h"

BOOL registrationSkipped;

@interface TNLaunchViewController ()

@property (strong, nonatomic) UILabel *appTitle;
@property (strong, nonatomic) TNButton *login;
@property (strong, nonatomic) TNButton *signup;
@property (strong, nonatomic) UIButton *skip;

@end

@implementation TNLaunchViewController

- (void)viewWillAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (!registrationSkipped) {
        [[self navigationController] setNavigationBarHidden:NO animated:YES];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    // Animation to bring up the two buttons from the bottom of the screen

    CGRect loginFrame = self.login.frame;
    loginFrame.origin.y = 388;

    CGRect skipFrame = self.skip.frame;
    skipFrame.origin.y = 458;

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];

    self.login.frame = loginFrame;
    self.skip.frame = skipFrame;

    [UIView commitAnimations];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor hnColor]];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];

    CGSize screenSize = self.view.bounds.size;

    UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(0, 380, 320, 200)];
    [bottom setBackgroundColor:[UIColor whiteColor]];

    self.appTitle = ({
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, screenSize.width, 100)];
        [title setText:@"THE NEWS"];
        [title setTextColor:[UIColor whiteColor]];
        [title setTextAlignment:NSTextAlignmentCenter];
        [title setFont:[UIFont fontWithName:@"Montserrat-Bold" size:40]];
        title;
    });

    self.login = ({
        TNButton *login = [[TNButton alloc] initWithFrame:CGRectMake(20, screenSize.height + 100, screenSize.width - 40, 60)];
        [login withText:@"Log In" normalColor:[UIColor whiteColor] highlightColor:[UIColor whiteColor] border:YES];
        [login addTarget:self action:@selector(loginButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        login;
    });

    self.skip = ({
        UIButton *skip = [UIButton buttonWithType:UIButtonTypeCustom ];
        [skip setFrame:CGRectMake(10, screenSize.height + 150, screenSize.width - 20, 50)];
        [skip setTitle:@"Skip to The News" forState:UIControlStateNormal];
        [skip setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //[skip setTitleColor:[UIColor hnColor] forState:UIControlStateHighlighted];
        [[skip titleLabel] setFont:[UIFont fontWithName:@"Montserrat-Regular" size:20]];
        [skip addTarget:self action:@selector(skipButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        skip;
    });

    [self.view addSubview:self.appTitle];
    [self.view addSubview:self.login];
    [self.view addSubview:self.skip];
}

- (void)signupButtonPressed:(id)selector
{
    TNSignupViewController *signupViewController = [[TNSignupViewController alloc] init];
    [self.navigationController pushViewController:signupViewController animated:YES];
}

- (void)loginButtonPressed:(id)selector
{
    TNLoginViewController *loginViewController = [[TNLoginViewController alloc] init];
    [self.navigationController pushViewController:loginViewController animated:YES];
}

- (void)skipButtonPressed:(id)selector
{
    registrationSkipped = YES;
    TNHomeViewController *homeViewController = [[TNHomeViewController alloc] init];
    [self.navigationController pushViewController:homeViewController animated:YES];

    // Remove Launch View Controllers As It Is No Longer Accessible
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [self.navigationController setViewControllers:@[[viewControllers lastObject]]];
}

@end