//
//  TransitionManager.swift
//  TransitionManager
//
//  Created by Vicente Suarez on 11/9/16.
//  Copyright © 2016 Vicente Suarez. All rights reserved.
//

import UIKit

public class TransitionManager {
    
    private let interactiveTransitioning: InteractiveTransitioning
    private let animatedTransitioning: AnimatedTransitioning
    private lazy var transitioningDelegate: TransitioningDelegate = {
        return TransitioningDelegate(animatedTransitioning: self.animatedTransitioning, interactiveTransitioning: self.interactiveTransitioning)
    }()
    
    /// Creates a new transitioning manager and configures the presenting view controller. Transitioning managers should be an instance property of the presenting view controller and should be allocated for the lifetime of the view controller.
    /// - Parameter source: The presenting view controller.
    /// - Parameter presentationType: Whether the view controller is presented/dismiss from a segue or by calling `presentViewController:animated:`.
    /// - Parameter direction: The direction of the present/dismiss gesture.
    public init<T: UIViewController>(source: T, presentationType: PresentationType, direction: PresentationDirection = .left) where T: TransitionSource {
        animatedTransitioning = AnimatedTransitioning(source: source)
        interactiveTransitioning = InteractiveTransitioning(source: source, presentationType: presentationType, direction: direction)
    }
    
    /// Configures the presented view controller.
    /// - Parameter destination: The presenting view controller.
    /// - Note: This method must be called before the view controller is presented.
    /// It is recommended to call it inside the presented view controller's `prepareForSegue:` method.
    public func setDestination<T: UIViewController>(_ destination: T) where T: TransitionDestination {
        destination.modalPresentationStyle = .custom
        destination.transitioningDelegate = transitioningDelegate
        animatedTransitioning.destination = destination
        interactiveTransitioning.setDestination(destination)
    }
}
