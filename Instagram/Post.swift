//
//  Post.swift
//  Instagram
//
//  Created by Lainie Wright on 2/27/16.
//  Copyright © 2016 lainiewright. All rights reserved.
//

import UIKit
import Parse

class Post: NSObject {
    
    var user: PFUser!
    var imageFile: PFFile!
    var text: String?
    //var createdAt: NSDate!
    
    init?(user: PFUser, imageFile: PFFile, text: String?) {
        self.user = user
        self.imageFile = imageFile
        self.text = text
        
        super.init()

    }
    
    class func PFObjectsToPosts(objects: [PFObject]) -> [Post] {
        var posts = [Post]()
        for object in objects {
            let post = Post(user: object["user"] as! PFUser, imageFile: object["imageFile"] as! PFFile, text: object["caption"] as? String)
            //post?.createdAt = object["createdAt"] as? NSDate
            posts.append(post!)
        }
        return posts
    }

    class func timeAgoSinceDate(date:NSDate) -> String {
        let calendar = NSCalendar.currentCalendar()
        let now = NSDate()
        let earliest = now.earlierDate(date)
        let latest = (earliest == now) ? date : now
        let momentsComponents = calendar.components([.Minute , .Hour , .Day , .WeekOfYear , .Month , .Year , .Second], fromDate: earliest, toDate: latest, options: NSCalendarOptions())
        
        let components = calendar.components([.Day, .Month, .Year], fromDate: date)
        
        if (momentsComponents.weekOfYear >= 1) {
            return "\(components.month)/\(components.day)/\(components.year)"
        } else if (momentsComponents.day >= 1) {
            return "\(momentsComponents.day)d"
        } else if (momentsComponents.hour >= 1) {
            return "\(momentsComponents.hour)h"
        } else if (momentsComponents.minute >= 1) {
            return "\(momentsComponents.minute)m"
        } else if (momentsComponents.second >= 2) {
            return "\(momentsComponents.second)s"
        } else {
            return "1s"
        }
        
    }
    
}
