//
//  Sample.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 6/12/16.
//  Copyright © 2016 Shuichi Tsutsumi. All rights reserved.
//

import Foundation

struct Sample {
    let title: String
    let detail: String
    let classPrefix: String
    
    func controller() -> UIViewController {
        let storyboard = UIStoryboard(name: classPrefix, bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() else {fatalError()}
        controller.title = title
        return controller
    }
}

struct SampleDataSource {
    let samples = [
        Sample(
            title: "Map Customizations",
            detail: "Flyover can be selected with new map types, and Traffic, Scale and Compass can be shown.",
            classPrefix: "MapCustomizations"
        ),
        Sample(
            title: "Text Detector",
            detail: "Text detection using new detector type \"CIDetectorTypeText\".",
            classPrefix: "TextDetect"
        ),
        Sample(
            title: "New Image Filters",
            detail: "New filters of CIFilter which can be used for Still Images.",
            classPrefix: "StillImageFilters"
        ),
        Sample(
            title: "Audio Unit Component Manager",
            detail: "Retrieve available audio units using AudioUnitComponentManager and apply them to a sound. If there are some Audio Unit Extensions, they will be also shown.",
            classPrefix: "AudioUnitComponentManager"
        ),
        Sample(
            title: "Speech Voices",
            detail: "Example for new properties which are added to AVSpeechSynthesisVoice such as language, name, quality...",
            classPrefix: "Speech"
        ),
        Sample(
            title: "CASpringAnimation",
            detail: "Animation example using CASpringAnimation.",
            classPrefix: "Spring"
        ),
        Sample(
            title: "Core Image Transitions",
            detail: "New transition effects which are added to CITransitionCategory.",
            classPrefix: "CoreImageTransitions"
        ),
        Sample(
            title: "UIStackView",
            detail: "Auto Layout example using UIStackView.",
            classPrefix: "StackView"
        ),
        Sample(
            title: "Selfies & Screenshots",
            detail: "Fetch photos filtered with new subtypes \"SelfPortraits\" and \"Screenshot\" which are added to Photos framework.",
            classPrefix: "Photos"
        ),
        Sample(
            title: "String Transform",
            detail: "String transliteration examples using new APIs of Foundation framework.",
            classPrefix: "StringTransform"
        ),
        Sample(
            title: "Search APIs",
            detail: "Example for Search APIs using NSUserActivity and Core Spotlight.",
            classPrefix: "SearchAPIs"
        ),
        Sample(
            title: "Content Blockers",
            detail: "Example for Content Blocker Extension.",
            classPrefix: "ContentBlocker"
        ),
        Sample(
            title: "SFSafariViewController",
            detail: "Open web pages with SFSafariViewController.",
            classPrefix: "Safari"
        ),
        Sample(
            title: "Attributes of New Filters",
            detail: "Extract new filters of CIFilter using \"kCIAttributeFilterAvailable_iOS\".",
            classPrefix: "Filters"
        ),
        Sample(
            title: "Low Power Mode",
            detail: "Detect changes of \"Low Power Mode\" setting.",
            classPrefix: "LowPowerMode"
        ),
        Sample(
            title: "New Fonts",
            detail: "Gallery of new fonts.",
            classPrefix: "Fonts"
        ),
        Sample(
            title: "Contacts",
            detail: "Contacts framework sample.",
            classPrefix: "Contacts"
        ),
        Sample(
            title: "ReplayKit",
            detail: "ReplayKit framework sample.",
            classPrefix: "ReplayKit"
        ),
        Sample(
            title: "Quick Actions",
            detail: "Access the shortcut menu on the Home screen using 3D Touch.",
            classPrefix: "QuickActions"
        ),
        Sample(
            title: "Force Touch",
            detail: "Visualize the forces of touches using new properties of UITouch.",
            classPrefix: "ForceTouch"
        ),
        Sample(
            title: "Live Photos",
            detail: "Show a Live Photo using \"PHLivePhotoView\"",
            classPrefix: "LivePhoto"
        ),
    ]
}