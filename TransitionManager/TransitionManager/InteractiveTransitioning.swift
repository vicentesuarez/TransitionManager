//
//  InteractiveTransitioning.swift
//  TransitionManager
//
//  Created by Vicente Suarez on 11/9/16.
//  Copyright © 2016 Vicente Suarez. All rights reserved.
//

import UIKit

class InteractiveTransitioning: UIPercentDrivenInteractiveTransition {
    
    // MARK: - Constants -
    
    private let minimumProgress: CGFloat = 0.0
    private let thresholdProgress: CGFloat = 0.5
    private let completeThreshold: CGFloat = 0.9
    private let maximumProgress: CGFloat = 1.0
    
    // MARK: - Cues -
    
    private(set) var interactionInProgress = false
    private var shouldCompleteTransition = false
    
    // MARK: - Properties -
    
    private let source: UIViewController
    private var destination: UIViewController?
    private var presentationType: PresentationType
    private var direction: PresentationDirection
    private var translationWidth: CGFloat?
    
    // MARK:  - Intialization -
    
    init(source: UIViewController, presentationType: PresentationType, direction: PresentationDirection = .left) {
        self.source = source
        self.presentationType = presentationType
        self.direction = direction
        super.init()
        
        let presentHandler = #selector(handlePresentationGesture(gestureRecognizer:))
        let gestureRecongnizer = UIScreenEdgePanGestureRecognizer(target: self, action: presentHandler)
        gestureRecongnizer.edges = direction == .left ? .left : .right
        source.view.addGestureRecognizer(gestureRecongnizer)
    }
    
    // MARK: - Setters -
    
    func setDestination<T: UIViewController>(_ destination: T) where T: TransitionDestination {
        self.destination = destination
        translationWidth = destination.translationWidth
        let dismissHandler = #selector(handleDismissGesture(gestureRecognizer:))
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: dismissHandler)
        destination.view.addGestureRecognizer(gestureRecognizer)
    }
    
    // MARK: - Gesture handling -
    
    func handlePresentationGesture(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        guard let translationView = gestureRecognizer.view else { return }
        
        let translation = gestureRecognizer.translation(in: translationView)
        var progress = translation.x * direction.rawValue / (translationWidth ?? translationView.bounds.width)
        progress = CGFloat(fmin(fmax(progress, minimumProgress), maximumProgress))
        
        switch gestureRecognizer.state {
        case .began:
            interactionInProgress = true
            switch presentationType {
            case .segue(let presentIdentifier, _):
                source.performSegue(withIdentifier: presentIdentifier, sender: self)
            case .presenting:
                guard let destination = destination else { return }
                source.present(destination, animated: true, completion: nil)
            }
        case .changed:
            shouldCompleteTransition = progress > thresholdProgress
            update(progress)
        default:
            interactionInProgress = false
            shouldCompleteTransition ? finish() : cancel()
        }
    }
    
    func handleDismissGesture(gestureRecognizer: UIPanGestureRecognizer) {
        guard let translationView = gestureRecognizer.view,
            let destination = destination else { return }
        
        let translation = gestureRecognizer.translation(in: translationView)
        let translationWidth = self.translationWidth ?? translationView.bounds.width
        
        var progress = -translation.x * direction.rawValue / translationWidth
        progress = CGFloat(fmin(fmax(progress, minimumProgress), maximumProgress))
        
        switch gestureRecognizer.state {
        case .began:
            interactionInProgress = true
            switch presentationType {
            case .segue(_, let dismissIdentifier):
                destination.performSegue(withIdentifier: dismissIdentifier, sender: self)
            case .presenting:
                destination.dismiss(animated: true, completion: nil)
            }
        case .changed:
            if progress >= completeThreshold {
                finish()
            } else {
                shouldCompleteTransition = progress > thresholdProgress
                update(progress)
            }
        default:
            interactionInProgress = false
            shouldCompleteTransition ? finish() : cancel()
        }
    }
}
