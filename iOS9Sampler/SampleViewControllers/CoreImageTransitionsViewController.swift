//
//  CoreImageTransitionsViewController.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 10/19/15.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

import UIKit

class CoreImageTransitionsViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak fileprivate var segmentedCtl: UISegmentedControl!
    fileprivate let transition = CoreImageTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // =========================================================================
    // MARK: - UINavigationControllerDelegate
    
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        switch segmentedCtl.selectedSegmentIndex {
        case 1:
            transition.type = CoreImageTransitionType.pageCurl
        case 2:
            transition.type = CoreImageTransitionType.pageCurlWithShadow
        default:
            transition.type = CoreImageTransitionType.ripple
        }
        transition.presenting = false
        return transition
    }
}
