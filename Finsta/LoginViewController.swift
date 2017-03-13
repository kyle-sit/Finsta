//
//  LoginViewController.swift
//  Finsta
//
//  Created by Kyle Sit on 3/12/17.
//  Copyright © 2017 Kyle Sit. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signUpButton.layer.cornerRadius = 5
        signInButton.layer.cornerRadius = 5
        signUpButton.clipsToBounds = true
        signInButton.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        //Error message for empty fields
        if( userNameTextfield.text == "" || passwordTextfield.text == "" ) {
            let alertController = UIAlertController(title: "Invalid", message: "One of the required fields is empty", preferredStyle: .alert)
            
            // create an OK action
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // handle response here.
            }
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
        }
        
        //Attempt to log in
        PFUser.logInWithUsername(inBackground: userNameTextfield.text!, password: passwordTextfield.text!) { (user: PFUser?, error: Error?) in
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            //User does not exist
            else {
                let errorString = error?.localizedDescription
                
                // Show the errorString somewhere and let the user try again.
                let alertController = UIAlertController(title: "Invalid", message: errorString, preferredStyle: .alert)
                
                // create an OK action
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    // handle response here.
                }
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                
                self.present(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }

            }
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        //Creating New User
        let newUser = PFUser()
        
        newUser.username = userNameTextfield.text
        newUser.password = passwordTextfield.text
        
        //Error message for empty fields
        if( newUser.username == "" || newUser.password == "" ) {
            let alertController = UIAlertController(title: "Invalid", message: "One of the required fields is empty", preferredStyle: .alert)
            
            // create an OK action
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // handle response here.
            }
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
        }
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if success {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            else {
                //User info already exists
                let errorString = error?.localizedDescription
                
                // Show the errorString somewhere and let the user try again.
                let alertController = UIAlertController(title: "Invalid", message: errorString, preferredStyle: .alert)
                
                // create an OK action
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    // handle response here.
                }
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                
                self.present(alertController, animated: true) {
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
