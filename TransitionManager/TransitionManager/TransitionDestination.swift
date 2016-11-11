//
//  TransitionDestination.swift
//  TransitionManager
//
//  Created by Vicente Suarez on 11/9/16.
//  Copyright © 2016 Vicente Suarez. All rights reserved.
//

import UIKit

/// Defines methods implemented by a presented view controller to animate presenting and dismissing.
@objc public protocol TransitionDestination: class {
    /// The time duration of the transition in seconds.
    var animationDuration: TimeInterval { get }
    /// Prepare the views to be animated for presentation.
    /// Parameter containerView: The upon which to draw the presenting.
    @objc optional func setupBeforePresenting(containerView: UIView)
    /// The total translation of the swipe gesture to present or dismiss the view controller which is considered 100% swipe. Default is the width of the window. However, it is recommended to implement this property so that a full swipe is short enough to be easy to perform by the user.
    @objc optional var translationWidth: CGFloat { get }
    /// Animate the presentation.
    /// There is no need to call `UIView`'s animate methods.
    @objc optional func animatePresentation()
    /// Move views to their final states and perform cleanup after presentation.
    /// - Parameter completed: `true` if the presentation completed, `false` otherwise.
    @objc optional func cleanupAfterPresenting(completed: Bool)
    /// Prepare the views to be animated for dismissal.
    @objc optional func setupBeforeDismissing()
    /// Animate the dismissal.
    /// There is no need to call `UIView`'s animate methods.
    @objc optional func animateDismissal()
    /// Move views to their final states and perform cleanup after dismissal.
    /// - Parameter completed: `true` if the dismissal completed, `false` otherwise.
    @objc optional func cleanupAfterDismissing(completed: Bool)
}
