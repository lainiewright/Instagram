//
//  InstagramCell.swift
//  Instagram
//
//  Created by Lainie Wright on 2/28/16.
//  Copyright © 2016 lainiewright. All rights reserved.
//

import UIKit

class InstagramCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
