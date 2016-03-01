//
//  CaptureViewController.swift
//  Instagram
//
//  Created by Lainie Wright on 2/23/16.
//  Copyright © 2016 lainiewright. All rights reserved.
//

import UIKit
import Parse

class CaptureViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var captionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectImageFromPhotoLibrary(sender: AnyObject) {
        
        // Hide the keyboard.
        captionTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        photoButton.setImage(selectedImage, forState: .Normal)
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onSubmit(sender: AnyObject) {
        let post = PFObject(className: "Post")
        let currentUser = PFUser.currentUser()
        post["user"] = currentUser
        
        let image = photoButton.imageView?.image
        let imageFile = getPFFileFromImage(image)
        post["imageFile"] = imageFile
        
        let caption = captionTextField.text
        post["caption"] = caption
        
        post.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success {
                let barViewControllers = self.tabBarController?.viewControllers
                let vc = barViewControllers![0] as! HomeViewController
                vc.data.insert(Post(user: currentUser!, imageFile: imageFile!, text: caption!)!, atIndex: 0)
                NSNotificationCenter.defaultCenter().postNotificationName("reload", object: nil)
                self.tabBarController?.selectedIndex = 0
            } else {
                print(error?.localizedDescription)
            }
        }
        photoButton.setImage(UIImage(named: "defaultPhoto"), forState: .Normal)
        captionTextField.text = ""
    }
    
    func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            let resizedImage = resize(image, newSize: CGSize(width: image.size.width/4, height: image.size.width/4))
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(resizedImage) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
