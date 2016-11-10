//
//  AnimatedTransitioning.swift
//  TransitionManager
//
//  Created by Vicente Suarez on 11/9/16.
//  Copyright © 2016 Vicente Suarez. All rights reserved.
//

import UIKit

class AnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    // MARK: - Constants -
    
    private let transitionDuration: TimeInterval = 0.3
    
    // MARK: - Properties -
    
    var isPresenting = true
    private var source: TransitionSource
    var destination: TransitionDestination?
    
    // MARK: - Initialization -
    
    init(source: TransitionSource) {
        self.source = source
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning -
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        let destination = transitionContext?.viewController(forKey: UITransitionContextViewControllerKey.to) as? TransitionDestination
        return destination?.animationDuration ?? transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch isPresenting {
        case true:
            animatePresentationWithTransitionContext(transitionContext: transitionContext)
        case false:
            animateDismissalWithTransitionContext(transitionContext: transitionContext)
        }
    }
    
    // MARK: - Animation -
    
    func animatePresentationWithTransitionContext(transitionContext: UIViewControllerContextTransitioning) {
        source.setupBeforePresenting?()
        destination?.setupBeforePresenting?(containerView: transitionContext.containerView)
        
        UIView.animate(withDuration: destination?.animationDuration ?? transitionDuration, animations: {
            self.source.animatePresentation?()
            self.destination?.animatePresentation?()
        }) { _ in
            let completed = !transitionContext.transitionWasCancelled
            self.source.cleanupAfterPresenting?(completed: completed)
            self.destination?.cleanupAfterPresenting?(completed: completed)
            transitionContext.completeTransition(completed)
        }
    }
    
    func animateDismissalWithTransitionContext(transitionContext: UIViewControllerContextTransitioning) {
        source.setupBeforeDismissing?()
        destination?.setupBeforeDismissing?()
        
        UIView.animate(withDuration: destination?.animationDuration ?? transitionDuration, animations: {
            self.source.animateDismissal?()
            self.destination?.animateDismissal?()
        }) { _ in
            let completed = !transitionContext.transitionWasCancelled
            self.source.cleanupAfterDismissing?(completed: completed)
            self.destination?.cleanupAfterDismissing?(completed: completed)
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
