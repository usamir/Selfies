//
//  ViewController.swift
//  Selfies
//
//  Created by Samir Uzunovic on 06/05/16.
//  Copyright © 2016 Samir Uzunovic. All rights reserved.
//

import UIKit
import Photos

class ViewController: UITableViewController {
    
    // support for selfies album
    var photo: UIImage!
    var images: [UIImage] = []
    var path: NSURL!
    var paths: [NSURL] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FetchCustomAlbumPhotos()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    // Fill cell with data
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("selfieCell")! as UITableViewCell
        
        var imagePath = self.paths[indexPath.row].relativePath!.characters.split{$0 == "/"}.map(String.init)
        cell.textLabel?.text = imagePath[imagePath.count - 1]

        let imageName = images[indexPath.row]
        cell.imageView?.image = imageName
        
        return cell
    }
    
    var selectedImage: UIImage!
    // Selected cell which will be detailed
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
        
        selectedImage = currentCell.imageView?.image
        performSegueWithIdentifier("Detail", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "Detail") {
            
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destinationViewController as! DetailViewController
            // your new view controller should have property that will store passed value
            viewController.newImage = selectedImage
        }
    }
    
    
    func FetchCustomAlbumPhotos() {
        let albumName = "SelfiesAlbum"
        var assetCollection = PHAssetCollection()
        var photoAssets = PHFetchResult()
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
        
        let collection : PHFetchResult =
            PHAssetCollection.fetchAssetCollectionsWithType(.Album, subtype: .Any, options: fetchOptions)
        if let _:AnyObject = collection.firstObject{
                //found the album
                assetCollection = collection.firstObject as! PHAssetCollection
        }
        
        photoAssets =
            PHAsset.fetchAssetsInAssetCollection(assetCollection, options: nil)
        let imageManager = PHCachingImageManager()
        photoAssets.enumerateObjectsUsingBlock {
            (object: AnyObject!, count: Int, stop: UnsafeMutablePointer<ObjCBool>) in if object is PHAsset{
                let asset = object as! PHAsset
                let imageSize = CGSize(width: asset.pixelWidth, height: asset.pixelHeight)
                
                // for faster performance, and maybe degraded image
                let options = PHImageRequestOptions()
                options.deliveryMode = .FastFormat
                options.synchronous = true
                imageManager.requestImageForAsset(asset, targetSize: imageSize, contentMode: .AspectFill, options: options, resultHandler: {
                    (image, info) -> Void in self.photo = image!
                    // get information of image
                    if info!.keys.contains(NSString(string: "PHImageFileURLKey"))
                    {
                       self.path = info![NSString(string: "PHImageFileURLKey")] as! NSURL
                    }
                    // Add image to array
                    self.addImgToArray(self.photo)
                    // Add path to array
                    self.addPathToArray(self.path)
                })
            }
        }
    }
    
    
    func addImgToArray(uploadImage: UIImage) {
        self.images.append(uploadImage)
    }
    
    func addPathToArray(uploadPath: NSURL) {
        self.paths.append(uploadPath)
    }

}

