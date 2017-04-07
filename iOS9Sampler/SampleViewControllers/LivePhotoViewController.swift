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
    
    @IBOutlet weak fileprivate var livePhotoView: PHLivePhotoView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        livePhotoView.contentMode = UIViewContentMode.scaleAspectFit
        livePhotoView.delegate = self        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // =========================================================================
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        dismiss(animated: true, completion: nil)
        
        print("\(info)")

        if let livePhoto = info[UIImagePickerControllerLivePhoto] as? PHLivePhoto {
            livePhotoView.livePhoto = livePhoto
            livePhotoView.startPlayback(with: .full)
        } else {
            let alert = UIAlertController(
                title: "Failed",
                message: "This is not a Live Photo.",
                preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(
                title: "OK",
                style: UIAlertActionStyle.cancel,
                handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    // =========================================================================
    // MARK: - PHLivePhotoViewDelegate
    
    func livePhotoView(_ livePhotoView: PHLivePhotoView, didEndPlaybackWith playbackStyle: PHLivePhotoViewPlaybackStyle) {
        livePhotoView.startPlayback(with: .full)
    }
    
    // =========================================================================
    // MARK: - Actions
    
    @IBAction func pickerBtnTapped(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.mediaTypes = [kUTTypeImage as String, kUTTypeLivePhoto as String]
        
        present(picker, animated: true, completion: nil)
    }
}

