//
//  PhotosDetailViewController.swift
//  Finsta
//
//  Created by Kyle Sit on 3/14/17.
//  Copyright © 2017 Kyle Sit. All rights reserved.
//

import UIKit

class PhotosDetailViewController: UIViewController, UITextViewDelegate {

    var originalImage: UIImage!
    var resizedImage: UIImage!
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Edit textview
        descriptionTextView.delegate = self
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor.black.cgColor
        descriptionTextView.layer.cornerRadius = 6;
        descriptionTextView.clipsToBounds = true;
        descriptionTextView.text = "Description Here"
        descriptionTextView.textColor = UIColor.lightGray
        
        //Edit imageView
        print(resizedImage.debugDescription)
        postImage.image = resizedImage;
        postImage.layer.cornerRadius = 6;
        postImage.clipsToBounds = true;
    }

    override func viewDidAppear(_ animated: Bool) {
        descriptionTextView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Description Here"
            textView.textColor = UIColor.lightGray
        }
        else{
            textView.resignFirstResponder()
        }
    }
    
    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func onShare(_ sender: Any) {
        Post.postUserImage(image: originalImage, withCaption: descriptionTextView.text) { (success: Bool, error: Error?) in
            
            
            self.performSegue(withIdentifier: "postedSegue", sender: nil)
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
