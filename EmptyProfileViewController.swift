//
//  EmptyProfileViewController.swift
//  OnCall
//
//  Created by Nikita Shenkman on 11/6/14.
//  Copyright (c) 2014 Marksman Apps. All rights reserved.
//

import UIKit
import CloudKit

class EmptyProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var window: UIView!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    let container: CKContainer
    let privateDB: CKDatabase
    
    var keyboardOpen = false
    var distToMove: CGFloat = 0
    
    required init(coder aDecoder: NSCoder) {
        container = CKContainer.defaultContainer()
        privateDB = container.privateCloudDatabase
        
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        container = CKContainer.defaultContainer()
        privateDB = container.privateCloudDatabase
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let center = NSNotificationCenter.defaultCenter()
        
        center.addObserver(self,
            selector: "handleKeyboardWillShow:",
            name: UIKeyboardWillShowNotification,
            object: nil)
        
        center.addObserver(self,
            selector: "handleKeyboardWillHide:",
            name: UIKeyboardWillHideNotification,
            object: nil)

        firstName.autocorrectionType = UITextAutocorrectionType.No
        lastName.autocorrectionType = UITextAutocorrectionType.No
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    

    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }

    func handleKeyboardWillShow(aNotification: NSNotification) {
        if (!keyboardOpen) {
            let info = aNotification.userInfo as NSDictionary?
            let rectValue = info![UIKeyboardFrameBeginUserInfoKey] as NSValue
            let kbHeight = rectValue.CGRectValue().size.height
            distToMove = 155 - kbHeight

            self.view.frame.offset(dx: 0, dy:  distToMove)
            keyboardOpen = true;
        }
    }
    
    func handleKeyboardWillHide(aNotification: NSNotification) {
        if (keyboardOpen) {
            
            let info = aNotification.userInfo as NSDictionary?
            let rectValue = info![UIKeyboardFrameBeginUserInfoKey] as NSValue
            let kbHeight = rectValue.CGRectValue().size.height
            
            self.view.frame.offset(dx: 0, dy: -distToMove)
            keyboardOpen = false;
        }
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
