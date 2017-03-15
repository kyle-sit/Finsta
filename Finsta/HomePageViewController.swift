//
//  HomePageViewController.swift
//  Finsta
//
//  Created by Kyle Sit on 3/12/17.
//  Copyright © 2017 Kyle Sit. All rights reserved.
//

import UIKit
import Parse

class HomePageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var feedTableView: UITableView!
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    
    var posts: [NSObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        feedTableView.delegate = self
        feedTableView.dataSource = self
        
        self.feedTableView.estimatedRowHeight = 350
        self.feedTableView.rowHeight = UITableViewAutomaticDimension
        
        takePhotoButton.layer.cornerRadius = 5
        profileButton.layer.cornerRadius = 5
        
        takePhotoButton.clipsToBounds = true
        profileButton.clipsToBounds = true
        
        getPosts()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        getPosts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getPosts() {
        let query = PFQuery(className: "Post")
        query.order(byDescending: "_created_at")
        query.includeKey("_p_author")
        query.limit = 20
        
        print("queried")
        
        // fetch data asynchronously
        query.findObjectsInBackground { (postsFromDB: [PFObject]?, error: Error?) in
            if let postsFromDB = postsFromDB {
                // do something with the data fetched
                self.posts = postsFromDB
                self.feedTableView.reloadData()
                
            } else {
                // handle error
            }
        }
        print("loaded posts to local")
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
    
    @IBAction func onTakePhotoClick(_ sender: Any) {
        self.performSegue(withIdentifier: "takePhotoSegue", sender: sender)
    }
    
    @IBAction func onProfileClick(_ sender: Any) {
        self.performSegue(withIdentifier: "profileSegue", sender: sender)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let posts = posts {
            print("not empty posts")
            return posts.count;
        } else {
            print("empty posts")
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = feedTableView.dequeueReusableCell(withIdentifier: "postCell") as! postCell
        print("got the cell")
        let finPost = posts?[indexPath.row]
        print("got the post")
        print(finPost ?? 0)
        cell.finstaPost = finPost as! PFObject
        
        print("making cells")
        
        return cell;
    }
    


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
