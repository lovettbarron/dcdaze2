//
//  OpenCardController.swift
//  daze-swipe
//
//  Created by Andrew Lovett Barron on 2016-07-13.
//  Copyright © 2016 RelayStudio. All rights reserved.
//

import Foundation
import UIKit

// Building from this
// https://www.raywenderlich.com/110536/custom-uiviewcontroller-transitions

class OpenCardAnimationController: NSObject, UIViewControllerAnimatedTransitioning {

    var originFrame = CGRectZero
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
            let containerView = transitionContext.containerView(),
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) else {
                return
        }

        let initialFrame = originFrame
        let finalFrame = transitionContext.finalFrameForViewController(toVC)
        
        let snapshot = toVC.view.snapshotViewAfterScreenUpdates(true)
        
        snapshot.frame = initialFrame
        snapshot.layer.cornerRadius = 25
        snapshot.layer.masksToBounds = true
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshot)
        toVC.view.hidden = true
        
        let duration = transitionDuration(transitionContext)
        
        UIView.animateKeyframesWithDuration(
            duration,
            delay: 0,
            options: .CalculationModeCubic,
            animations: {

                // Reduce cell to category image and animate out cells
                UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 1/5, animations: {
                    
                })
                
                // Increase cell view to occupy full width.
                UIView.addKeyframeWithRelativeStartTime(0.4, relativeDuration: 1/5, animations: {
                    
                })
                
                // Overlay CardViewController view
                UIView.addKeyframeWithRelativeStartTime(0.45, relativeDuration: 1/5, animations: {
                    
                })
                
                // Animate in key elements for CardViewController view
                UIView.addKeyframeWithRelativeStartTime(0.45, relativeDuration: 1/5, animations: {
                    
                })
                
                //
                UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 1/5, animations: {
                    snapshot.frame = finalFrame
                })

            },
            completion: { _ in
                toVC.view.hidden = false
                snapshot.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
        
    }
}