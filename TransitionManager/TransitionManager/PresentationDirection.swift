//
//  PresentationDirection.swift
//  TransitionManager
//
//  Created by Vicente Suarez on 11/9/16.
//  Copyright © 2016 Vicente Suarez. All rights reserved.
//

import Foundation

/// Represents the swipe origin to begin presentation of
/// view controller
public enum PresentationDirection: CGFloat {
    /// Swipe left to right
    case left = 1.0
    /// Swipe right to left
    case right = -1.0
}
