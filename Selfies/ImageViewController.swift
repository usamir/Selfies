//
//  LoadImageViewController.swift
//  Selfies
//
//  Created by Samir Uzunovic on 06/05/16.
//  Copyright © 2016 Samir Uzunovic. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // image support
    var images:[UIImage] = []
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        
        if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
            
            let cameraPicker = UIImagePickerController()
            cameraPicker.delegate = self
            cameraPicker.sourceType = .Camera
        
            self.presentViewController(cameraPicker, animated: true, completion: nil)
        } else {
            let alertNoCamera = UIAlertController(title: "No Camera",
                                                  message: "The device has no camera",
                                                  preferredStyle: .Alert)
            let pressOK = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alertNoCamera.addAction(pressOK)
            
            self.presentViewController(alertNoCamera, animated: true, completion: nil)
        }
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            images.append(pickedImage)
            imgView.image = pickedImage
            
            UIImageWriteToSavedPhotosAlbum(pickedImage, self, #selector(ImageViewController.image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
        
        
    }
    
    // dismiss after cancel
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo: UnsafePointer<Void>) {
        if error != nil {
            let alert = UIAlertController(title: "Save Failed", message: "Failed to save image!", preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Ok", style: .Cancel, handler: nil)
            
            alert.addAction(cancelAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
}
