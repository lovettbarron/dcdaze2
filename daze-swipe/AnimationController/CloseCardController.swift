//
//  CloseCardController.swift
//  daze-swipe
//
//  Created by Andrew Lovett Barron on 2016-07-14.
//  Copyright © 2016 RelayStudio. All rights reserved.
//

import Foundation
import UIKit

// Building from this
// https://www.raywenderlich.com/110536/custom-uiviewcontroller-transitions


class CloseCardAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    var destinationFrame = CGRectZero
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.6
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
            let containerView = transitionContext.containerView(),
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) else {
                return
        }
        
        let finalFrame = destinationFrame
        
        let snapshot = fromVC.view.snapshotViewAfterScreenUpdates(false)
        
        snapshot.layer.cornerRadius = 25
        snapshot.layer.masksToBounds = true
        
//        containerView.addSubview(toVC.view) <-- This was causing the "blank" thing.
        containerView.addSubview(snapshot)
        fromVC.view.hidden = true
        
//        AnimationHelper.perspectiveTransformForContainerView(containerView)
        
        
        let duration = transitionDuration(transitionContext)
        
        UIView.animateKeyframesWithDuration(
            duration,
            delay: 0,
            options: .CalculationModeCubic,
            animations: {
                
                
                // placeholder
                UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 1, animations: {
                    snapshot.frame = finalFrame
                })
            },
            completion: { _ in
                fromVC.view.hidden = false
                snapshot.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
    }
}