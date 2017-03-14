//
//  TakePhotoViewController.swift
//  Finsta
//
//  Created by Kyle Sit on 3/14/17.
//  Copyright © 2017 Kyle Sit. All rights reserved.
//

import UIKit

class TakePhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var uploadedImage: UIImage?
    var resizedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
    // Get the image captured by the UIImagePickerController
    let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
    let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
    
    self.uploadedImage = resize(image: originalImage, newSize: CGSize(width: 800, height: 800))
    self.resizedImage = resize(image: editedImage, newSize: CGSize(width: 800, height: 800))
    
    self.performSegue(withIdentifier: "addDetailsSegue", sender: nil)
        
    // Dismiss UIImagePickerController to go back to your original view controller
    dismiss(animated: true, completion: nil)
    }
    
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }

    
    @IBAction func chooseToTake(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraVC = UIImagePickerController()
            cameraVC.delegate = self
            cameraVC.allowsEditing = true
            cameraVC.sourceType = UIImagePickerControllerSourceType.camera
            self.present(cameraVC, animated: true, completion: nil)
            
        } else {
            let alertController = UIAlertController(title: "Invalid", message: "No Camera Available", preferredStyle: .alert)
            
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
    
    
    @IBAction func chooseFromRoll(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let vc = UIImagePickerController()
            vc.delegate = self
            vc.allowsEditing = true
            vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
            self.present(vc, animated: true, completion: nil)
        }
        else {
            let alertController = UIAlertController(title: "Invalid", message: "No Photo Libary Available", preferredStyle: .alert)
            
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
    
    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addDetailsSegue") {
            let destination = segue.destination as! PhotosDetailViewController
            //destination.finstaPic.image = finstaPic
            /*if(self.uploadedImage == nil) {
                print("why is this nil")
            }
            print("not nil")*/
            destination.originalImage = self.uploadedImage
            destination.resizedImage = self.resizedImage
            
        }
    }

}
