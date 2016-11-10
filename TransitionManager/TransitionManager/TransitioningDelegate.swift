//
//  TransitioningDelegate.swift
//  TransitionManager
//
//  Created by Vicente Suarez on 11/9/16.
//  Copyright © 2016 Vicente Suarez. All rights reserved.
//

import UIKit

class TransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    private var interactiveTransitioning: InteractiveTransitioning
    private var animatedTransitioning: AnimatedTransitioning
    
    init(animatedTransitioning: AnimatedTransitioning, interactiveTransitioning: InteractiveTransitioning) {
        self.animatedTransitioning = animatedTransitioning
        self.interactiveTransitioning = interactiveTransitioning
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animatedTransitioning.isPresenting = true
        return animatedTransitioning
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animatedTransitioning.isPresenting = false
        return animatedTransitioning
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransitioning.interactionInProgress ? interactiveTransitioning : nil
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransitioning.interactionInProgress ? interactiveTransitioning : nil
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return nil
    }
}
