//
//  LoginViewController.swift
//  ParseMash
//
//  Created by Don Miller on 1/1/15.
//  Copyright (c) 2015 GroundSpeed. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet var txtUsername: UITextField!
    @IBOutlet var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnLogin(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(txtUsername.text, password:txtPassword.text) {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                self.navigationController?.popToRootViewControllerAnimated(true)
            } else {
                let alert = UIAlertView()
                alert.title = "Sorry!"
                alert.message = error.userInfo!["error"] as NSString
                alert.addButtonWithTitle("OK")
                alert.show()
            }
        }
    }
}
