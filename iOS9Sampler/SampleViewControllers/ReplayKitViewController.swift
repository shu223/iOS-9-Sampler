//
//  ReplayKitViewController.swift
//  iOS9Sampler
//
//  Created by manhattan918 on 2015/10/25.
//  Copyright © 2015 manhattan918. All rights reserved.
//

import UIKit
import ReplayKit

class ReplayKitViewController: UIViewController, RPScreenRecorderDelegate, RPPreviewViewControllerDelegate {

    @IBOutlet weak fileprivate var startRecordingButton: UIButton!
    @IBOutlet weak fileprivate var stopRecordingButton: UIButton!
    @IBOutlet weak fileprivate var processingView: UIActivityIndicatorView!
    fileprivate let recorder = RPScreenRecorder.shared()
    
    
    // =========================================================================
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recorder.delegate = self
        processingView.isHidden = true
        buttonEnabledControl(recorder.isRecording)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // =========================================================================
    // MARK: - RPScreenRecorderDelegate
    
    // called after stopping the recording
    func screenRecorder(_ screenRecorder: RPScreenRecorder, didStopRecordingWithError error: Error, previewViewController: RPPreviewViewController?) {
        NSLog("Stop recording")
    }
    
    // called when the recorder availability has changed
    func screenRecorderDidChangeAvailability(_ screenRecorder: RPScreenRecorder) {
        let availability = screenRecorder.isAvailable
        NSLog("Availablility: \(availability)")
    }
    
    
    // =========================================================================
    // MARK: - RPPreviewViewControllerDelegate
    
    // called when preview is finished
    func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        NSLog("Preview finish")
        
        DispatchQueue.main.async { [unowned previewController] in
            // close preview window
            previewController.dismiss(animated: true, completion: nil)
        }
    }
    
    
    // =========================================================================
    // MARK: - IBAction
    
    @IBAction func startRecordingButtonTapped(_ sender: AnyObject) {
        processingView.isHidden = false
        
        // start recording
        recorder.startRecording(withMicrophoneEnabled: true) { [unowned self] error in
            DispatchQueue.main.async { [unowned self] in
                self.processingView.isHidden = true
            }
            
            if let error = error {
                NSLog("Failed start recording: \(error.localizedDescription)")
                return
            }
            
            NSLog("Start recording")
            self.buttonEnabledControl(true)
        }
    }
    
    @IBAction func stopRecordingButtonTapped(_ sender: AnyObject) {
        processingView.isHidden = false
        
        // end recording
        recorder.stopRecording(handler: { [unowned self] (previewViewController, error) in
            DispatchQueue.main.async { [unowned self] in
                self.processingView.isHidden = true
            }
            
            self.buttonEnabledControl(false)
            
            if let error = error {
                NSLog("Failed stop recording: \(error.localizedDescription)")
                return
            }
            
            NSLog("Stop recording")
            previewViewController?.previewControllerDelegate = self
            
            DispatchQueue.main.async { [unowned self] in
                // show preview window
                self.present(previewViewController!, animated: true, completion: nil)
            }
        })
    }
    
    
    // =========================================================================
    // MARK: - Helper
    
    // control the enabled of each button
    fileprivate func buttonEnabledControl(_ isRecording: Bool) {
        DispatchQueue.main.async { [unowned self] in
            let enebledColor = UIColor(red: 0.0, green: 122.0/255.0, blue:1.0, alpha: 1.0)
            let disabledColor = UIColor.lightGray
            
            if !self.recorder.isAvailable {
                self.startRecordingButton.isEnabled = false
                self.startRecordingButton.backgroundColor = disabledColor
                self.stopRecordingButton.isEnabled = false
                self.stopRecordingButton.backgroundColor = disabledColor
                
                return
            }
            
            self.startRecordingButton.isEnabled = !isRecording
            self.startRecordingButton.backgroundColor = isRecording ? disabledColor : enebledColor
            self.stopRecordingButton.isEnabled = isRecording
            self.stopRecordingButton.backgroundColor = isRecording ? enebledColor : disabledColor
        }
    }
    
    fileprivate func createHaloAt(_ location: CGPoint, withRadius radius: CGFloat) {
        
        let halo = PulsingHaloLayer()
        halo.repeatCount = 1
        halo.position = location
        halo.radius = radius * 2.0
        halo.fromValueForRadius = 0.5
        halo.keyTimeForHalfOpacity = 0.7
        halo.animationDuration = 0.8
        view.layer.addSublayer(halo)
    }

    
    // =========================================================================
    // MARK: - Touch Handler
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: view)
            let radius = touch.majorRadius
            
            createHaloAt(location, withRadius: radius)
        }
    }
}
