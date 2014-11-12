//
//  FirstViewController.swift
//  OnCall
//
//  Created by Adam Markon on 10/11/14.
//  Copyright (c) 2014 Marksman Apps. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    let kLoggedInKey = "userIsLoggedIn"
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        var isLoggedIn = userDefaults.boolForKey(kLoggedInKey)
        if isLoggedIn == false {
            let lc = LoginViewController(nibName: "LoginViewController", bundle: nil)
            self.presentViewController(lc, animated: animated, completion: nil)
        }
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
