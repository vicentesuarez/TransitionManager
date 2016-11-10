//
//  TransitionSource.swift
//  TransitionManager
//
//  Created by Vicente Suarez on 11/9/16.
//  Copyright © 2016 Vicente Suarez. All rights reserved.
//

import Foundation

/// Defines methods implemented by a presenting view controller to animate presenting and dismissing.
@objc public protocol TransitionSource: class {
    /// Prepare the views to be animated for presentation.
    @objc optional func setupBeforePresenting()
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
