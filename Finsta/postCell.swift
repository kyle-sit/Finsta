//
//  postCell.swift
//  Finsta
//
//  Created by Kyle Sit on 3/14/17.
//  Copyright © 2017 Kyle Sit. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class postCell: UITableViewCell {

    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var postImage: PFImageView!
    
    var finstaPost: PFObject! { //PFObject we will give to each table cell
        didSet {
            //now that we have the PFObject, we can do things specifically in it
            self.postImage.file = finstaPost["media"] as? PFFile
            self.postImage.loadInBackground()
            self.caption.text = finstaPost["caption"] as? String
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
