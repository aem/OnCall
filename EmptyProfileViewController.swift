//
//  EmptyProfileViewController.swift
//  OnCall
//
//  Created by Nikita Shenkman on 11/6/14.
//  Copyright (c) 2014 Marksman Apps. All rights reserved.
//

import UIKit

class EmptyProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{

    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var window: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func get_photo(sender: AnyObject) {
        var picker = UIImagePickerController();
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
        
        //image is the the image that they choose from their photo library
        circlePhoto(image)
    }

    func circlePhoto(image: UIImage) {


        imageView.image = image
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.clipsToBounds = true
    }
    
    @IBAction func finished(sender: UIButton) {
        let vc = storyboard?.instantiateViewControllerWithIdentifier("vc") as SecondViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
