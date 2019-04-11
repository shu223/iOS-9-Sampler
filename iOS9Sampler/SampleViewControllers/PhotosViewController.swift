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
    
    @IBOutlet weak fileprivate var segmentedCtl: UISegmentedControl!
    
    fileprivate var images: [PHAsset]! = []
    fileprivate let imageManager = PHCachingImageManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Retrieve only screenshots
    //   reference: http://koze.hatenablog.jp/entry/2015/06/24/230000
    fileprivate func fetchScreenshots() {
        let result = PHAsset.fetchAssets(with: .image, options: nil)
        result.enumerateObjects({ [unowned self] (asset, index, stop) -> Void in
            // Append only screenshots
            if asset.mediaSubtypes.contains(.photoScreenshot) {
                self.images.append(asset)
            }
        })
    }
    
    // Retrieve only Self Portraits
    //   reference: http://koze.hatenablog.jp/entry/2015/07/23/090000
    fileprivate func fetchSelfies() {
        // Fetch asset collections of Self Portraits.
        let resultCollections = PHAssetCollection.fetchAssetCollections(
            with: .smartAlbum,
            subtype: .smartAlbumSelfPortraits,
            options: nil)
        resultCollections.enumerateObjects({ (collection, index, stop) -> Void in
            let result = PHAsset.fetchAssets(in: collection, options: nil)
            result.enumerateObjects({ [unowned self] (asset, index, stop) -> Void in
                self.images.append(asset)
            })
        })
    }
    
    fileprivate func reloadData() {
        
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
                preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(
                title: "OK",
                style: UIAlertAction.Style.cancel,
                handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    // =========================================================================
    // MARK: - UICollectionViewataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotosCell
        
        let asset = images[indexPath.item]
        
        imageManager.requestImage(
            for: asset,
            targetSize: cell.imageView.frame.size,
            contentMode: .aspectFill,
            options: nil) { image, _ in
                cell.imageView.image = image
        }
        
        return cell
    }
    
    // =========================================================================
    // MARK: - Actions
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        reloadData()
    }
}
