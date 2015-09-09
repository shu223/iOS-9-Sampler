# iOS-9-Sampler

Code examples for the new features of iOS 9.


##How to build

JUST BUILD with **Xcode 7**.


##Contents

###Text Detector

Text detection using new detector type "CIDetectorTypeText".

<img src="ResourcesForREADME/textdetector.jpg" width="200">


###New Image Filters

New filters of CIFilter which can be used for Still Images.

<img src="ResourcesForREADME/imagefilter.jpg">

（From left: Original, CICMYKHalftone, CIKaleidscope, CIPointillize）

**NOTE:** 29 filters are supported in this example, however **"CIEdgeWork" and "CISpotLight" don't work correctly** with current code. I would much appreciated your pull request!


###Map Customizations

**Flyover** can be selected with new map types, and **Traffic**, Scale and Compass can be shown.

<img src="ResourcesForREADME/map2.jpg" width="405">


###Audio Unit Component Manager

Retrieve audio unit components using AudioUnitComponentManager and apply them to a sound using some new methods. If there are some Audio Unit Extensions, they will be also shown in the components list.

<img src="ResourcesForREADME/aucomponents.jpg" width="200">


###Speech Voices

Example for new properties which are added to AVSpeechSynthesisVoice such as language, name, quality...

<img src="ResourcesForREADME/speech.jpg" width="200">


###Content Blockers

Example for Content Blocker Extensions.

<img src="ResourcesForREADME/blocker.jpg" width="200">


###Attributes of New Filters

Attributes viewer for **41 new filters** of CIFilter.

<img src="ResourcesForREADME/filterattributes.jpg" width="405">
