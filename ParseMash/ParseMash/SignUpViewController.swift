//
//  SignUpViewController.swift
//  ParseMash
//
//  Created by Don Miller on 1/1/15.
//  Copyright (c) 2015 GroundSpeed. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet var txtUsername: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var txtEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSignUp(sender: AnyObject) {
        let username: String = self.txtUsername.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let password: String = self.txtPassword.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let email: String = self.txtEmail.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        
        if (countElements(username) == 0 || countElements(password) == 0 || countElements(email) == 0)
        {
            let alert = UIAlertView()
            alert.title = "Oops!"
            alert.message = "Make sure you enter an username, password, and email address!"
            alert.addButtonWithTitle("OK")
            alert.show()
        }
        else
        {
            var newUser = PFUser()
            newUser.username = username
            newUser.password = password
            newUser.email = email
            
            newUser.signUpInBackgroundWithBlock {
                (succeeded: Bool!, error: NSError!) -> Void in
                if error == nil {
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
}
