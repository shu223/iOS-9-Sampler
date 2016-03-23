//
//  CoreImageTransitionsViewController.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 10/19/15.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

import UIKit


class CoreImageTransitionsViewController: UIViewController, UINavigationControllerDelegate {

    
    @IBOutlet weak private var segmentedCtl: UISegmentedControl!
    private var transition: CoreImageTransition?
    
    
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
        navigationController: UINavigationController,
        animationControllerForOperation operation: UINavigationControllerOperation,
        fromViewController fromVC: UIViewController,
        toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        transition = CoreImageTransition()
        
        switch segmentedCtl.selectedSegmentIndex {
        case 1:
            transition?.type = CoreImageTransitionType.PageCurl
        case 2:
            transition?.type = CoreImageTransitionType.PageCurlWithShadow
        default:
            transition?.type = CoreImageTransitionType.Ripple
        }
        transition?.presenting = false
        return transition
    }
}
