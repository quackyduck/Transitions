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

/*
- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    return nil;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return nil;
}
 */

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return TRANSITION_DURATION;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
//    UIView *containerView = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    FirstViewController *first = (FirstViewController *)fromViewController;
//    SecondViewController *second = (SecondViewController *)toViewController;
    
    UIView *container = transitionContext.containerView;
    
    CGRect beginFrame = [container convertRect:first.imageView.frame fromView:first.imageView];
//    CGRect endFrame = [transitionContext initialFrameForViewController:fromViewController];
//    CGRect endFrame = [container convertRect:second.imageView.frame fromView:second.imageView];
    CGRect endFrame = CGRectMake(beginFrame.origin.x, beginFrame.origin.y + 250, beginFrame.size.width, beginFrame.size.height);
    
    UIView *move = nil;
    
    if (self.isPresenting) {
        
//        toViewController.view.frame = beginFrame;
//        move = [second.imageView snapshotViewAfterScreenUpdates:YES];
        move = [first.imageView snapshotViewAfterScreenUpdates:YES];
        move.frame = beginFrame;
        
//        second.imageView.image = [UIImage imageNamed:@"rat.jpg"];
//        second.imageView.alpha = 0;
        
    } else {
        
        move = [first.imageView snapshotViewAfterScreenUpdates:YES];
        move.frame = fromViewController.view.frame;
        [fromViewController.view removeFromSuperview];
        
    }
    
    [container addSubview:move];
    [UIView animateWithDuration:TRANSITION_DURATION delay:0
         usingSpringWithDamping:500 initialSpringVelocity:15
                        options:0 animations:^{
                            move.frame = self.isPresenting ?  endFrame : beginFrame;
//                            second.imageView.alpha = 1;
                            first.imageView.alpha = 0;
                            first.view.alpha = 0;
                        }
                     completion:^(BOOL finished) {
                         if (self.isPresenting) {
                             [move removeFromSuperview];
                             toViewController.view.frame = first.view.frame;
                             UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rat.jpg"]];
                             imageView.frame = endFrame;
                             [toViewController.view addSubview:imageView];
                             [container addSubview:toViewController.view];
                         } else {

                         }
                         
                         [transitionContext completeTransition: YES];
                     }];
    
    
}

//// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
//- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
//    
//    UIView *containerView = [transitionContext containerView];
//    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    
//    if (self.isPresenting) {
//        
//        FirstViewController *first = (FirstViewController *)fromViewController;
//        SecondViewController *second = (SecondViewController *)toViewController;
//        
//        UIView *fromView = first.view;
//        UIView *toView = second.view;
//        
//        second.imageView.image = [UIImage imageNamed:@"rat.jpg"];
//        
//        [containerView addSubview:toView];
//        
//        
////        CGRect beginFrame = [containerView convertRect:first.imageView.frame fromView:fromView];
//////        CGRect endFrame = [transitionContext initialFrameForViewController:first];
//////        
//////        toView.frame = endFrame;
//////        
//////        UIView *move = [toView snapshotViewAfterScreenUpdates:YES];
//////        move.frame = beginFrame;
////        
////        
////        
////        CGRect endFrame = CGRectMake(beginFrame.origin.x, beginFrame.origin.y + 250, beginFrame.size.width, beginFrame.size.height);
//////        CGRect endFrame = [containerView convertRect:second.imageView.frame toView:toView];
////        UIView *move = first.imageView;
////        
////
//////        CGRect destination = second.imageView.frame;
//////        second.imageView.frame = first.imageView.frame;
////    
//////        toViewController.view.frame = containerView.frame;
//////        [containerView addSubview:toViewController.view];
//////        
//////        toViewController.view.alpha = 0;
//////        toViewController.view.transform = CGAffineTransformMakeScale(0, 0);
////        
////        [containerView addSubview:move];
////
//        
//        UIView *move = [toView snapshotViewAfterScreenUpdates:YES];
//        move.frame = first.imageView.frame;
//        
//        CGRect endFrame = second.imageView.frame;
//        
////        
//        [UIView animateWithDuration:2 animations:^{
////            toViewController.view.alpha = 1;
////            toViewController.view.transform = CGAffineTransformMakeScale(0.9f, 0.9f);
//            
////            move.frame = endFrame;
//            
//            
//            
//            move.frame = endFrame;
//            
//            
//            
//        } completion:^(BOOL finished) {
//            [transitionContext completeTransition:YES];
//        }];
//    } else {
//        
////        [UIView animateWithDuration:2 animations:^{
////            fromViewController.view.alpha = 0;
////            fromViewController.view.transform = CGAffineTransformMakeScale(0, 0);
////            
////            
////        } completion:^(BOOL finished) {
////            [transitionContext completeTransition:YES];
////        }];
//        
//        [containerView addSubview:fromViewController.view];
//        
//        
//    }
//    
//}

@end
