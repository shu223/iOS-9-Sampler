//
//  ReplayKitViewController.swift
//  iOS9Sampler
//
//  Created by manhattan918 on 2015/10/25.
//  Copyright © 2015年 manhattan918. All rights reserved.
//

import UIKit
import ReplayKit

class ReplayKitViewController: UIViewController, RPScreenRecorderDelegate, RPPreviewViewControllerDelegate {

    @IBOutlet weak var startRecordingButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var processingView: UIActivityIndicatorView!
    private let recorder = RPScreenRecorder.sharedRecorder()
    
    
    // =========================================================================
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recorder.delegate = self
        processingView.hidden = true
        buttonEnabledControl(recorder.recording)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // =========================================================================
    // MARK: - RPScreenRecorderDelegate
    
    // called after stopping the recording
    func screenRecorder(screenRecorder: RPScreenRecorder, didStopRecordingWithError error: NSError, previewViewController: RPPreviewViewController?) {
        NSLog("Stop recording")
    }
    
    // called when the recorder availability has changed
    func screenRecorderDidChangeAvailability(screenRecorder: RPScreenRecorder) {
        let availability = screenRecorder.available
        NSLog("Availablility: \(availability)")
    }
    
    
    // =========================================================================
    // MARK: - RPPreviewViewControllerDelegate
    
    // called when preview is finished
    func previewControllerDidFinish(previewController: RPPreviewViewController) {
        NSLog("Preview finish")
        
        dispatch_async(dispatch_get_main_queue()) { [unowned previewController] in
            // close preview window
            previewController.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
    // =========================================================================
    // MARK: - IBAction
    
    @IBAction func startRecordingButtonTapped(sender: AnyObject) {
        processingView.hidden = false
        
        // start recording
        recorder.startRecordingWithMicrophoneEnabled(true) { [unowned self] error in
            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                self.processingView.hidden = true
            }
            
            if let error = error {
                NSLog("Failed start recording: \(error.localizedDescription)")
                return
            }
            
            NSLog("Start recording")
            self.buttonEnabledControl(true)
        }
    }
    
    @IBAction func stopRecordingButtonTapped(sender: AnyObject) {
        processingView.hidden = false
        
        // end recording
        recorder.stopRecordingWithHandler({ [unowned self] (previewViewController, error) in
            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                self.processingView.hidden = true
            }
            
            self.buttonEnabledControl(false)
            
            if let error = error {
                NSLog("Failed stop recording: \(error.localizedDescription)")
                return
            }
            
            NSLog("Stop recording")
            previewViewController?.previewControllerDelegate = self
            
            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                // show preview window
                self.presentViewController(previewViewController!, animated: true, completion: nil)
            }
        })
    }
    
    
    // =========================================================================
    // MARK: - Helper
    
    // control the enabled of each button
    private func buttonEnabledControl(isRecording: Bool) {
        dispatch_async(dispatch_get_main_queue()) { [unowned self] in
            let enebledColor = UIColor(red: 0.0, green: 122.0/255.0, blue:1.0, alpha: 1.0)
            let disabledColor = UIColor.lightGrayColor()
            
            if !self.recorder.available {
                self.startRecordingButton.enabled = false
                self.startRecordingButton.backgroundColor = disabledColor
                self.stopRecordingButton.enabled = false
                self.stopRecordingButton.backgroundColor = disabledColor
                
                return
            }
            
            self.startRecordingButton.enabled = !isRecording
            self.startRecordingButton.backgroundColor = isRecording ? disabledColor : enebledColor
            self.stopRecordingButton.enabled = isRecording
            self.stopRecordingButton.backgroundColor = isRecording ? enebledColor : disabledColor
        }
    }
    
    private func createHaloAt(location: CGPoint, withRadius radius: CGFloat) {
        
        let halo = PulsingHaloLayer()
        halo.repeatCount = 1
        halo.position = location
        halo.radius = radius * 2.0
        halo.fromValueForRadius = 0.5
        halo.keyTimeForHalfOpacity = 0.7
        halo.animationDuration = 0.8
        self.view.layer.addSublayer(halo)
    }

    
    // =========================================================================
    // MARK: - Touch Handler
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for obj: AnyObject in touches {
            
            let touch = obj as! UITouch
            let location = touch.locationInView(self.view)
            let radius = touch.majorRadius
            
            self.createHaloAt(location, withRadius: radius)
        }
    }
}
