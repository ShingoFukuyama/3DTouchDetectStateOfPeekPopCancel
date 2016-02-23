//
//  ViewController.swift
//  PreviewState
//
//  Created by FukuyamaShingo on 2/24/16.
//  Copyright © 2016 FukuyamaShingo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIViewControllerPreviewingDelegate {
    
    let circleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "3D Touch not supported"
        
        let diameter:CGFloat = 180
        circleLabel.frame = CGRectMake(0, 0, diameter, diameter)
        circleLabel.backgroundColor = UIColor.redColor()
        self.view.addSubview(circleLabel)
        circleLabel.center = self.view.center
        circleLabel.layer.masksToBounds = true
        circleLabel.layer.cornerRadius = diameter * 0.5
        circleLabel.text = "3D Touch!"
        circleLabel.textAlignment = .Center
        circleLabel.font = UIFont.systemFontOfSize(22.0)
        circleLabel.textColor = UIColor.whiteColor()
        circleLabel.userInteractionEnabled = true // UILabel's default value is false
        
        if self.traitCollection.forceTouchCapability == .Available {
            self.navigationItem.title = "3D Touch supported"
            self.registerForPreviewingWithDelegate(self, sourceView: circleLabel)
        }
    }
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        // Observe 3d touch gesture
        let gesture = previewingContext.previewingGestureRecognizerForFailureRelationship
        gesture.addObserver(self, forKeyPath: "state", options: .New, context: nil)
        
        // Setup view controller for previewing
        let secondViewController = SecondViewController()
        secondViewController.previewingContext = previewingContext
        let diameter:CGFloat = CGRectGetWidth(self.view.frame)
        secondViewController.preferredContentSize = CGSizeMake(diameter, diameter)
        secondViewController.view.frame = CGRectMake(0, 0, diameter, diameter)
        secondViewController.view.layer.cornerRadius = diameter * 0.5
        return secondViewController;
    }
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
        if viewControllerToCommit.isKindOfClass(SecondViewController) {
            // 3D Touch state changed from Peek to Pop
            let secondViewController = SecondViewController()
            self.navigationController?.pushViewController(secondViewController, animated: true)
            self.navigationItem.title = "Committed"
        }
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        // Observe 3d touch gesture
        // can recognize peeking and canceling commit
        if let object = object {
            if keyPath == "state" {
                let newValue = change![NSKeyValueChangeNewKey]!.integerValue
                let state = UIGestureRecognizerState(rawValue: newValue)!
                switch state {
                case .Began, .Changed:
                    self.navigationItem.title = "Peeking"
                case .Ended, .Failed, .Cancelled:
                    self.navigationItem.title = "Not committed"
                    object.removeObserver(self, forKeyPath: "state")
                case .Possible:
                    break
                }
            }
        }
    }
}

