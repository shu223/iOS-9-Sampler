//
//  PhotosViewController.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 9/9/15.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//
//  Thanks to:
//  - http://koze.hatenablog.jp/entry/2015/07/23/090000
//  - http://koze.hatenablog.jp/entry/2015/06/24/230000


import UIKit
import Photos

class PhotosViewController: UICollectionViewController {

    @IBOutlet weak private var segmentedCtl: UISegmentedControl!
    
    private var images: [PHAsset]! = []
    private let imageManager = PHCachingImageManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Retrieve only screenshots
    //   reference: http://koze.hatenablog.jp/entry/2015/06/24/230000
    private func fetchScreenshots() {
        let result = PHAsset.fetchAssetsWithMediaType(.Image, options: nil)
        result.enumerateObjectsUsingBlock({ [unowned self] (object, index, stop) -> Void in
            guard let asset = object as? PHAsset else {fatalError()}
            // Append only screenshots
            if Bool(asset.mediaSubtypes.rawValue & PHAssetMediaSubtype.PhotoScreenshot.rawValue) {
                self.images.append(asset)
            }
            })
    }
    
    // Retrieve only Self Portraits
    //   reference: http://koze.hatenablog.jp/entry/2015/07/23/090000
    private func fetchSelfies() {
        // Fetch asset collections of Self Portraits.
        let resultCollections = PHAssetCollection.fetchAssetCollectionsWithType(
            .SmartAlbum,
            subtype: .SmartAlbumSelfPortraits,
            options: nil)
        resultCollections.enumerateObjectsUsingBlock({ (object, index, stop) -> Void in
            guard let collection = object as? PHAssetCollection else {fatalError()}
            let result = PHAsset.fetchAssetsInAssetCollection(collection, options: nil)
            result.enumerateObjectsUsingBlock({ [unowned self] (object, index, stop) -> Void in
                let asset = object as! PHAsset
                self.images.append(asset)
                })
        })
    }
    
    private func reloadData() {
        
        images.removeAll()
        
        if segmentedCtl.selectedSegmentIndex == 0 {
            fetchScreenshots()
        } else if segmentedCtl.selectedSegmentIndex == 1 {
            fetchSelfies()
        }
        
        collectionView?.reloadData()
        
        if images.count == 0 {
            let alert = UIAlertController(
                title: "NO DATA",
                message: "Couldn't fetch any photos for the selected subtype.",
                preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(
                title: "OK",
                style: UIAlertActionStyle.Cancel,
                handler: nil)
            alert.addAction(okAction)
            presentViewController(alert, animated: true, completion: nil)
        }
    }

    // =========================================================================
    // MARK: - UICollectionViewataSource
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! PhotosCell
        
        let asset = images[indexPath.item]
        
        imageManager.requestImageForAsset(
            asset,
            targetSize: cell.imageView.frame.size,
            contentMode: .AspectFill,
            options: nil) { image, _ in
                cell.imageView.image = image
        }

        return cell
    }
    
    // =========================================================================
    // MARK: - Actions
    
    @IBAction func segmentChanged(sender: UISegmentedControl) {
        
        reloadData()
    }
}
