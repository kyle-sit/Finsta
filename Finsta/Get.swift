//
//  Get.swift
//  Finsta
//
//  Created by Kyle Sit on 3/14/17.
//  Copyright © 2017 Kyle Sit. All rights reserved.
//

import UIKit
import Parse

class Get: NSObject {
    class func getAllPics(){
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                // do something with the data fetched
            } else {
                // handle error
            }
        }
    }
}
