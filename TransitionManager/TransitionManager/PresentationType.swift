//
//  PresentationType.swift
//  TransitionManager
//
//  Created by Vicente Suarez on 11/9/16.
//  Copyright © 2016 Vicente Suarez. All rights reserved.
//

import Foundation

/// Represents the two different ways of presenting a view controller.
public enum PresentationType {
    /// Segue based presentation
    /// Associated values:
    /// - Presenting segue name
    /// - Dismissing segue name
    case segue(presenting: String, dismissing: String)
    /// Presented using `presentViewController:animated`
    case presenting
}
