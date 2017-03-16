//
//  FriendTableViewCell.swift
//  PayYay
//
//  Created by Zhiqiang Lin on 3/7/17.
//  Copyright © 2017 Zhiqiang Lin. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    var friends = [User]()
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
