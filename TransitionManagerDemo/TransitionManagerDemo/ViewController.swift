//
//  ViewController.swift
//  TransitionManagerDemo
//
//  Created by Vicente Suarez on 1/13/17.
//  Copyright © 2017 Vicente Suarez. All rights reserved.
//

import UIKit
import TransitionManager

class ViewController: UIViewController, TransitionSource {
    
    var transitionManager: TransitionManager!

    @IBAction func unwindToMain(_ segue: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transitionManager = TransitionManager(source: self, presentationType: PresentationType.segue(presenting: "PresentMenuSegue", dismissing: "DismissMenuSegue"))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let menuViewController = segue.destination as? MenuViewController {
            transitionManager.setDestination(menuViewController)
        }
    }
}

