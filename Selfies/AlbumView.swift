//
//  AlbumView.swift
//  Selfies
//
//  Created by Samir Uzunovic on 06/05/16.
//  Copyright © 2016 Samir Uzunovic. All rights reserved.
//

import UIKit

class AlbumView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

 func showAlbum() {
 let cameraPicker = UIImagePickerController()
 cameraPicker.delegate = self
 cameraPicker.sourceType = .PhotoLibrary
 
 self.presentedViewController(cameraPicker, animated: true, completion: nil)
 }
}