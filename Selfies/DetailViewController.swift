//
//  DetailViewController.swift
//  Selfies
//
//  Created by Samir Uzunovic on 10/05/16.
//  Copyright © 2016 Samir Uzunovic. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // detail image support
    @IBOutlet weak var image: UIImageView!
    var newImage: UIImage!
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidLoad()
        
        image?.image = newImage
        
    }
    
    // share bar button action
    @IBAction func onShare(sender: UIBarButtonItem) {
        let activityController = UIActivityViewController(activityItems: ["check this out", image.image!], applicationActivities: nil)
        presentViewController(activityController, animated: true, completion: nil)
    }
    
}

