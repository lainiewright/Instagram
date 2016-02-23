//
//  HomeViewController.swift
//  Instagram
//
//  Created by Lainie Wright on 2/23/16.
//  Copyright © 2016 lainiewright. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController {
    
    var user: PFUser!

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = PFUser.currentUser()

        if let text = user.username {
            label.text = "Hello, \(text)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        PFUser.logOutInBackgroundWithBlock { (error:NSError?) -> Void in
            print("You're logged out.")
            self.performSegueWithIdentifier("logoutSegue", sender: nil)
        }
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
