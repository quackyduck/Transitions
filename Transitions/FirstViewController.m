//
//  FirstViewController.m
//  Transitions
//
//  Created by Nicolas Melo on 7/27/14.
//  Copyright (c) 2014 melo. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"

#define TRANSITION_DURATION 1.0

@interface FirstViewController ()
@property (nonatomic, assign) BOOL isPresenting;
@property (assign, nonatomic) CGFloat startScale;
@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.isPresenting = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIImage *image = [UIImage imageNamed:@"rat.jpg"];
    self.imageView.image = image;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSecondButton:(id)sender {
    
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    secondVC.modalPresentationStyle = UIModalPresentationCustom;
    secondVC.transitioningDelegate = self;
    
    [self presentViewController:secondVC animated:YES completion:nil];
    
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    self.isPresenting = YES;
    
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.isPresenting = NO;
    return self;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return TRANSITION_DURATION;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {

    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    
    NSLog(@"From: %@", fromViewController.class);
    NSLog(@"To: %@", toViewController.class);
    
    UIView *container = transitionContext.containerView;
    
    CGRect beginFrame;
    CGRect endFrame;
    
    UIView *move = nil;
    FirstViewController *first = nil;
    SecondViewController *second = nil;
    
    if (self.isPresenting) {
        
        first = (FirstViewController *)fromViewController;
        second = (SecondViewController *)toViewController;
        
        beginFrame = first.imageView.frame;
        endFrame = second.imageView.frame;
        
        move = [first.imageView snapshotViewAfterScreenUpdates:YES];
        move.frame = beginFrame;
        first.imageView.alpha = 0;
        first.view.alpha = 1;
        
    } else {
        
        first = (FirstViewController *)toViewController;
        second = (SecondViewController *)fromViewController;
        
        endFrame = first.imageView.frame;
        beginFrame = second.imageView.frame;
        
        move = [second.imageView snapshotViewAfterScreenUpdates:YES];
        move.frame = beginFrame;
        second.imageView.alpha = 0;
        second.view.alpha = 1;
        
    }
    
    [container addSubview:move];
    
    [UIView animateWithDuration:TRANSITION_DURATION animations:^{
        NSLog(@"Animation...");
        move.frame = endFrame;
        fromViewController.view.alpha = 0;
        toViewController.view.alpha = 1;
        
        
    } completion:^(BOOL finished) {
        NSLog(@"Completion...");
        [move removeFromSuperview];
        [container addSubview:toViewController.view];
        [transitionContext completeTransition: YES];
        
        if (self.isPresenting) {
            second.imageView.alpha = 1;
        } else {
            first.imageView.alpha = 1;
        }
        
        
    }];
    
    
}

@end
