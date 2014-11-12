//
//  LoginViewController.swift
//  OnCall
//
//  Created by Nikita Shenkman on 11/6/14.
//  Copyright (c) 2014 Marksman Apps. All rights reserved.
//

import UIKit
import CloudKit

class LoginViewController: UIViewController {
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var password: UITextField!
    let container: CKContainer
    let privateDB: CKDatabase
    
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
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login() {
        // TODO: Handle airplane mode
        // TODO: Handle not logged in to iCloud
        let pred = NSPredicate(format: "TRUEPREDICATE")
        let queryAll = CKQuery(recordType: "AccountInfo", predicate: pred)
        var loggedIn = false
        privateDB.performQuery(queryAll, inZoneWithID: nil) { (results, error) -> Void in
            if error != nil {
                dispatch_async(dispatch_get_main_queue(), {
                    showBasicAlert("Error!",
                        message: error.localizedDescription)
                })
                return
            }
            for record in results as [CKRecord] {
                let currPhone = record.valueForKey("phone_number") as String
                let currPass = record.valueForKey("password") as String
                
                if currPhone == self.phoneNumber.text &&
                    currPass == self.password.text {
                        loggedIn = true
                        dispatch_async(dispatch_get_main_queue(), {
                            showBasicAlert("Logged in!", message: nil)
                        })
                        
                        return // TODO: Segue to main view controller
                }
            }
            if !loggedIn {
                dispatch_async(dispatch_get_main_queue(), {
                    showBasicAlert("Error!",
                        message: "Phone number or password are incorrect. " +
                        "Please try again.")
                })
            }
        }
    }
    
    @IBAction func openSignUpScreen() {
        let vc = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    private func userDoesntExist(phone: String) -> Bool {
        let pred = NSPredicate(format: "TRUEPREDICATE")
        let queryAll = CKQuery(recordType: "AccountInfo", predicate: pred)
        var numberFound = false
        privateDB.performQuery(queryAll, inZoneWithID: nil) { (results, error) -> Void in
            if error != nil {
                dispatch_async(dispatch_get_main_queue(), {
                    showBasicAlert("Error!", message: error.localizedDescription)
                })
                return
            }
            for record in results as [CKRecord] {
                let currPhone = record.valueForKey("phone_number") as String
                var numberFound = numberFound || (currPhone == self.phoneNumber.text)
            }
            if !numberFound {
                dispatch_async(dispatch_get_main_queue(), {
                    showBasicAlert("Account already exists!", message: "Please try logging in.")
                })
            }
        }
        return numberFound
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
