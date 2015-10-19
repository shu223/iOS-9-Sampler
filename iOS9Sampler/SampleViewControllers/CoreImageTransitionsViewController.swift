//
//  CoreImageTransitionsViewController.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 10/19/15.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

import UIKit


class CoreImageTransitionsViewController: UIViewController, UINavigationControllerDelegate {

    
    @IBOutlet weak var segmentedCtl: UISegmentedControl!
    var transition: CoreImageTransition?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    // =========================================================================
    // MARK: - UINavigationControllerDelegate
    
    func navigationController(
        navigationController: UINavigationController,
        animationControllerForOperation operation: UINavigationControllerOperation,
        fromViewController fromVC: UIViewController,
        toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        print(__FUNCTION__+"\n")

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
