//
//  LoginViewController.swift
//  OnCall
//
//  Created by Nikita Shenkman on 11/6/14.
//  Copyright (c) 2014 Marksman Apps. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   @IBAction func login_button(sender: UIButton) {
    let vc = FirstViewController()
    self.presentViewController(vc, animated: true, completion: nil);
    }
    
    @IBAction func login() {
        
    }
    
    @IBAction func openSignUpScreen() {
        let vc = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
        self.presentViewController(vc, animated: true, completion: nil)
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
