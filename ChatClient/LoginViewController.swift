//
//  ViewController.swift
//  ChatClient
//
//  Created by Anisha Jain on 4/12/17.
//  Copyright © 2017 Anisha Jain. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        //let emailId = emailText.text
        //let password = passwordText.text
        myMethod()
    }
    
    @IBAction func onLogin(_ sender: Any) {
        
        let username = emailText.text
        let pass = passwordText.text
       
        
        PFUser.logInWithUsername(inBackground: username!, password: pass!) { (user: PFUser?, error: Error?) in
            if user != nil {
                print("I am logedin")
                self.performSegue(withIdentifier: "chatSegue", sender: nil)
            } else {
                print("The login failed. Check error to see why.", error?.localizedDescription)
            }
        }
        
    }
    
    func myMethod() {
        var user = PFUser()
        user.username = emailText.text
        user.password = passwordText.text
        user.email = "krishna1234@example.com"
        // other fields can be set just like with PFObject
        //user["phone"] = "415-392-0202"
        
        user.signUpInBackground(block: { (succeeded: Bool, error: Error?) in
            if let error = error {
                //let errorString = error.userInfo["error"] as? NSString
                print(error.localizedDescription)
                
                // Show the errorString somewhere and let the user try again.
            } else {
                self.performSegue(withIdentifier: "sigupSegue", sender: nil)
                // Hooray! Let them use the app now.
            }
        })
    }
    
    
    }

