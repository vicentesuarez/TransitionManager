//
//  MenuViewController.swift
//  TransitionManagerDemo
//
//  Created by Vicente Suarez on 1/13/17.
//  Copyright © 2017 Vicente Suarez. All rights reserved.
//

import UIKit
import TransitionManager

class MenuViewController: UIViewController, TransitionDestination {

    var animationDuration: TimeInterval { return 0.3 }
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var leftConstraint: NSLayoutConstraint!
    
    func setupBeforePresenting(containerView: UIView) {
        containerView.addSubview(view)
        view.frame = containerView.bounds
        view.leftAnchor.constraint(equalTo: containerView.leftAnchor)
        view.rightAnchor.constraint(equalTo: containerView.rightAnchor)
        view.topAnchor.constraint(equalTo: containerView.topAnchor)
        view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        view.layoutIfNeeded()
    }
    
    func animatePresentation() {
        leftConstraint.constant = 0
        backgroundView.alpha = 1.0
        view.layoutIfNeeded()
    }
    
    func animateDismissal() {
        leftConstraint.constant = -320.0
        backgroundView.alpha = 0
        view.layoutIfNeeded()
    }
    
    func cleanupAfterDismissing(completed: Bool) {
        if !completed {
            leftConstraint.constant = 0
            backgroundView.alpha = 1.0
            view.layoutIfNeeded()
        }
    }
}


