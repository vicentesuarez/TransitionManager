# Transition Manager
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](./LICENSE)

The Transition Manager is a Swift framework that makes it easy to create custom iOS transitions.

![Transition Manager Demo](media/TransitionManagerDemo.gif?raw=true "Transition Manager Demo")

## Minimum Requirements

### Runtime:
- iOS 8.0

### Build Time:
- Xcode 8.2.1
- Swift 3.0.2

## Installation

### [Carthage]

[Carthage]: https://github.com/Carthage/Carthage

Add the following to your Cartfile:

```ruby
github "vicentesuarez/TransitionManager"
```

Then run `carthage update`.

Follow the current instructions in [Carthage's README][carthage-installation]
for up to date installation instructions.

[carthage-installation]: https://github.com/Carthage/Carthage/blob/master/README.md

### Manual

1. Clone this repo or click "Download ZIP" on the side.
2. Copy all of the Swift files in the "TransitionManager/Transition Manager" folder into your project. You probably want to check the box that says "Copy items if needed" as well as make sure that the target you want to add the files to is checked.

## Usage

### Basic Setup

Add the import inside the source and destination View Controllers.

```swift
import TransitionManager

class ViewController: UIViewController { }
```

Implement the `TransitionDestination` protocol in the destination View Controller. The protocol requires implementing the `animationDuration` get only variable. Also, add the destination View Controller's view inside the `setupBeforePresenting(containerView:)` method.

```swift
class DestinationViewController: UIViewController, TransitionDestination {

    var animationDuration: TimeInterval { return 0.3 }

    func setupBeforePresenting(containerView: UIView) {
        containerView.addSubview(view)
        view.frame = containerView.bounds
        view.leftAnchor.constraint(equalTo: containerView.leftAnchor)
        view.rightAnchor.constraint(equalTo: containerView.rightAnchor)
        view.topAnchor.constraint(equalTo: containerView.topAnchor)
        view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        view.layoutIfNeeded()
    }
}
```

Next, implement the `TransitionSource` protocol in the source View Controller. Initialize the `TransitionManager` inside of `viewDidLoad()`. Override `prepare(for segue:sender:)`, retrieve your destination View Controller and add it to the transition manager.

```swift
import TransitionManager

class SourceViewController: UIViewController, TransitionSource {

    var transitionManager: TransitionManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transitionManager = TransitionManager(source: self, presentationType: .segue(presenting: "PresentMenuSegue", dismissing: "DismissMenuSegue"))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? DestinationViewController {
            transitionManager.setDestination(destinationViewController)
        }
    }
}
```

### Add custom animation

The transition `TransitionSource` and `TransitionDestination` protocols have methods to handler setup, animation and clean-up of transitions.

```swift
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
```