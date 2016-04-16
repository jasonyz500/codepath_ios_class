//
//  Member.swift
//  Homely
//
//  Created by John Franklin on 10/17/15.
//  Copyright © 2015 lollerballer. All rights reserved.
//

import UIKit

class Member: NSObject {
    var name : String = "John"
    var title : String = "Dad"
    var ageRestriction : AgeRestriction = AgeRestriction.adult
    var profileImage : UIImage
    init(name: String, title: String, ageRestriction: AgeRestriction, profileImage: UIImage) {
        self.name = name
        self.ageRestriction = ageRestriction
        self.title = title
        self.profileImage = profileImage
    }
}
