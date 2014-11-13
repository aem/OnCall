

//
//  SignUpViewController.swift
//  OnCall
//
//  Created by Nikita Shenkman on 11/6/14.
//  Copyright (c) 2014 Marksman Apps. All rights reserved.
//

import UIKit
import CloudKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPass: UITextField!
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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func returnToLogin(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func signUp() {
        // TODO: Handle Airplane mode
        // TODO: Handle not logged in to iCloud
        if self.validatePhone(phoneNumber.text) &&
            validatePassword(password.text) &&
             !userDoesntExist(phoneNumber.text) {
                var accountInfo = CKRecord(recordType: "AccountInfo")
                accountInfo.setValue(phoneNumber.text, forKey: "phone_number")
                accountInfo.setValue(password.text, forKey: "password")
                privateDB.saveRecord(accountInfo, completionHandler: { (record, error) -> Void in
                    if error != nil {
                        dispatch_async(dispatch_get_main_queue(), {
                            showBasicAlert("Error!", message: error.localizedDescription)
                        })
                    } else {
                        dispatch_async(dispatch_get_main_queue(), {
                            showBasicAlert("Done!",
                                           message: "You're all signed up, now go log in!")
                        })
                        self.returnToLogin(UIButton())
                    }
                });
        }
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
                NSLog(currPhone)
                var numberFound = numberFound || (currPhone == self.phoneNumber.text)
            }
            if !numberFound && results.count != 0 {
                dispatch_async(dispatch_get_main_queue(), {
                    showBasicAlert("Account already exists!", message: "Please try logging in.")
                })
            }
        }
        return numberFound
    }
    
    private func validatePhone(phone: String) -> Bool {
        if NSAttributedString(string: phone).length != 10 {
            showBasicAlert("Phone Number Invalid",
                message: "Phone number should be 10 digits long. Please check that " +
                "you entered your number correctly.")
            return false
        } else if phone.toInt() == nil {
            showBasicAlert("Invalid Character(s)",
                message: "One or more of the characters you entered was not a number. " +
                "Please check that you entered your number correctly.")
            return false
        } else if password.text != confirmPass.text {
            showBasicAlert("Passwords Don't Match",
                message: "The passwords you entered don't " +
                "match. Please check that the information you entered is correct.")
            return false
        }
        return true
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
