//
//  MovieViewCell.swift
//  RottenTomatoes
//
//  Created by Jason Zhou on 9/12/15.
//  Copyright © 2015 lollerballer. All rights reserved.
//

import UIKit
import AFNetworking

class MovieViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
