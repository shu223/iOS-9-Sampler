//
//  LivePhotoViewController.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 12/4/15.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

import UIKit
import Photos
import PhotosUI
import MobileCoreServices


class LivePhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PHLivePhotoViewDelegate {

    
    @IBOutlet weak private var livePhotoView: PHLivePhotoView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        livePhotoView.contentMode = UIViewContentMode.ScaleAspectFit
        livePhotoView.delegate = self        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    // =========================================================================
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        print("\(info)")

        if let livePhoto = info[UIImagePickerControllerLivePhoto] as? PHLivePhoto {

            livePhotoView.livePhoto = livePhoto
            livePhotoView.startPlaybackWithStyle(.Full)
        }
        else {
            let alert = UIAlertController(
                title: "Failed",
                message: "This is not a Live Photo.",
                preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(
                title: "OK",
                style: UIAlertActionStyle.Cancel,
                handler: nil)
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

    
    // =========================================================================
    // MARK: - PHLivePhotoViewDelegate
    
    func livePhotoView(livePhotoView: PHLivePhotoView, didEndPlaybackWithStyle playbackStyle: PHLivePhotoViewPlaybackStyle) {
        print(__FUNCTION__+"\n")
        
        livePhotoView.startPlaybackWithStyle(.Full)
    }
    
    
    // =========================================================================
    // MARK: - Actions
    
    @IBAction func pickerBtnTapped(sender: UIButton) {
        
        let picker = UIImagePickerController()
        picker.sourceType = .PhotoLibrary
        picker.delegate = self
        picker.mediaTypes = [kUTTypeImage as String, kUTTypeLivePhoto as String]
        
        self.presentViewController(picker, animated: true, completion: nil)
    }
}

