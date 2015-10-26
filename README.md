# iOS-9-Sampler

[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat
)](https://developer.apple.com/swift)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat
)](http://mit-license.org)


Code examples for the new features of iOS 9.


##How to build

JUST BUILD with **Xcode 7**.


##Contents

###Map Customizations

**Flyover** can be selected with new map types, and **Traffic**, Scale and Compass can be shown.

<!--<img src="ResourcesForREADME/map2.jpg" width="405">-->

![](ResourcesForREADME/map.gif)


###Text Detector

Text detection using new detector type "CIDetectorTypeText".

<img src="ResourcesForREADME/textdetector.jpg" width="200">


###New Image Filters

New filters of CIFilter which can be used for Still Images.

<img src="ResourcesForREADME/imagefilters.gif">

**NOTE:** 29 filters are supported in this example, however **"CISpotLight" don't work correctly** with current code. I would much appreciated your pull request!


###Audio Unit Component Manager

Retrieve audio unit components using AudioUnitComponentManager and apply them to a sound using some new methods. If there are some Audio Unit Extensions, they will be also shown in the components list.

<img src="ResourcesForREADME/aucomponents.jpg" width="200">


###Speech Voices

Example for new properties which are added to AVSpeechSynthesisVoice such as language, name, quality...

<img src="ResourcesForREADME/speech.jpg" width="200">


###CASpringAnimation

Animation example using CASpringAnimation.

![](ResourcesForREADME/spring.gif)

###UIStackView

Auto Layout example using UIStackView.

![](ResourcesForREADME/uistackview.gif)

###Selfies & Screenshots

Fetch photos filtered with new subtypes `PHAssetCollectionSubtype.SmartAlbumSelfPortraits` and `PHAssetMediaSubtype.PhotoScreenshot` which are added to Photos framework.

<img src="ResourcesForREADME/screenshots.jpg" width="200">


###String Transform

**String transliteration** examples using new APIs of Foundation framework.

<img src="ResourcesForREADME/stringtransform.jpg" width="200">


###Core Image Transitions

New transition effects which are added to `CITransitionCategory`.

![](ResourcesForREADME/ripple.gif)

###Search APIs

Example for Search APIs using NSUserActivity and **Core Spotlight**.

<img src="ResourcesForREADME/searchapis.jpg" width="200">


###Content Blockers

Example for Content Blocker Extensions.

<img src="ResourcesForREADME/blocker.jpg" width="200">


###SFSafariViewController

Open web pages with SFSafariViewController.

<img src="ResourcesForREADME/safari.jpg" width="200">


###Attributes of New Filters

Extract new filters of CIFilter using `kCIAttributeFilterAvailable_iOS`. There are **41 new filters**.

<img src="ResourcesForREADME/filterattributes.jpg" width="405">


###Low Power Mode

Detect changes of "Low Power Mode" setting.


###New Fonts

Gallery of **31 new fonts**.

<img src="ResourcesForREADME/fonts.jpg" width="200">


###Contacts (Created by [manhattan918](https://github.com/manhattan918))

Contacts framework sample.

<img src="ResourcesForREADME/contacts.jpg" width="200">


###ReplayKit (Created by [manhattan918](https://github.com/manhattan918))

ReplayKit framework sample.

<img src="ResourcesForREADME/replaykit.jpg" width="200">


###Quick Actions (3D Touch)  

Press the Icon on Home screen deeply, so you can access to the shortcut menu.

<img src="ResourcesForREADME/shortcut.jpg" width="200">

Please see `UIApplicationShortcutItems` key in Info.plist and `application:performActionForShortcutItem:completionHandler:` method in AppDelegate to know how it's implemented.

**NOTE:** Your device have to support 3D Touch.

###Force Touch (3D Touch)

Visualize the forces of touches using new properties of UITouch `force` and `maximumPossibleForce`.

![](ResourcesForREADME/forcetouch.gif)

**NOTE:** Your device have to support 3D Touch.

##watchOS-2-Sampler

You can check the **examples for watchOS 2** features on [watchOS-2-Sampler](https://github.com/shu223/watchOS-2-Sampler)!!

<a href="https://github.com/shu223/watchOS-2-Sampler"><img src="ResourcesForREADME/watchos2sampler.jpg" width="200"></a>

<img src="https://raw.githubusercontent.com/shu223/watchOS-2-Sampler/master/ResourcesForREADME/animation.gif" align="left" hspace="1">

<img src="https://raw.githubusercontent.com/shu223/watchOS-2-Sampler/master/ResourcesForREADME/tableanim.gif" align="left" hspace="1">

<img src="https://raw.githubusercontent.com/shu223/watchOS-2-Sampler/master/ResourcesForREADME/crownanim.gif" align="left" hspace="1">

<br clear="both">

- https://github.com/shu223/watchOS-2-Sampler


##Author

**Shuichi Tsutsumi** (Freelance iOS engineer)

- [Twitter](https://twitter.com/shu223)
- [Facebook](https://www.facebook.com/shuichi.tsutsumi)
- [LinkedIn](https://www.linkedin.com/profile/view?id=214896557)
- [Blog (Japanese)](http://d.hatena.ne.jp/shu223/)

##Special Thanks

The icon is designed by [Okazu](https://www.facebook.com/pashimo)
