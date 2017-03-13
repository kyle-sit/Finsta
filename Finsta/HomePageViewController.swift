//
//  HomePageViewController.swift
//  Finsta
//
//  Created by Kyle Sit on 3/12/17.
//  Copyright © 2017 Kyle Sit. All rights reserved.
//

import UIKit
import Parse

class HomePageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logout(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) in
            if error != nil {
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
            else {
                //PFUser is cleared
                self.performSegue(withIdentifier: "logoutSegue", sender: nil)
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
