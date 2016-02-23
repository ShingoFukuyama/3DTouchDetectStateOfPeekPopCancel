//
//  SecondViewController.swift
//  PreviewState
//
//  Created by FukuyamaShingo on 2/24/16.
//  Copyright © 2016 FukuyamaShingo. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    weak var previewingContext: UIViewControllerPreviewing?
    let indicator = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Label to indicate peeking or not
        indicator.textColor = UIColor.whiteColor()
        indicator.font = UIFont.systemFontOfSize(24)
        indicator.textAlignment = .Center
        self.view.addSubview(indicator)
        var center = self.view.center
        center.y = 100
        indicator.frame = CGRectMake(0, 0, 300, 30)
        indicator.center = center
        
        // Check peeking
        var isPeeking = false
        if let context = previewingContext {
            let state = context.previewingGestureRecognizerForFailureRelationship.state
            if state == .Began
                || state == .Changed {
                    isPeeking = true
            }
        }
        if isPeeking {
            indicator.text = "Peeking Now!"
            self.view.backgroundColor = UIColor(red: 0.3, green: 0.8, blue: 0.3, alpha: 1.0)
        }
        else {
            indicator.text = "Popped."
            self.view.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.8, alpha: 1.0)
        }
    }
    
    override func previewActionItems() -> [UIPreviewActionItem] {
        // Options
        let item1 = UIPreviewAction(title: "Action 1", style: .Default) { (action:UIPreviewAction, viewController:UIViewController) -> Void in
            print("\(__FUNCTION__):: Action 1 selected.");
        }
        let item2 = UIPreviewAction(title: "Action 2", style: .Destructive) { (action:UIPreviewAction, viewController:UIViewController) -> Void in
            print("\(__FUNCTION__):: Action 2 selected.");
        }
        let item3 = UIPreviewAction(title: "Action 3", style: .Selected) { (action:UIPreviewAction, viewController:UIViewController) -> Void in
            print("\(__FUNCTION__):: Action 3 selected.");
        }
        return [item1, item2, item3]
    }
}
