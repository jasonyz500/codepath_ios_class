//
//  Task.swift
//  Homely
//
//  Created by Jason Zhou on 10/10/15.
//  Copyright © 2015 lollerballer. All rights reserved.
//

import UIKit

enum Difficulty : String {  // Swift 2.0; for < 2.0 use Printable
    case easy = "easy";
    case medium = "medium";
    case hard = "hard";
    var description : String {
        switch self {
        case .easy: return "easy";
        case .medium: return "medium";
        case .hard: return "hard";
        }
    }
}


enum AgeRestriction : String  {  // Swift 2.0; for < 2.0 use Printable
    case kid = "kid";
    case youth = "youth";
    case adult = "adult";
    case senior = "senior";
    
    var description : String {
        switch self {
            // Use Internationalization, as appropriate.
        case .kid: return "kid";
        case .youth: return "youth";
        case .adult: return "adult";
        case .senior: return "senior";
        }
    }
}

enum RecurrenceDeadline : CustomStringConvertible {
    case sun;
    case mon;
    case tue;
    case wed;
    case thu;
    case fri;
    case sat;
    
    var description: String {
        switch self {
        case .sun: return "Sun"
        case .mon: return "Mon"
        case .tue: return "Tue"
        case .wed: return "Wed"
        case .thu: return "Thu"
        case .fri: return "Fri"
        case .sat: return "Sat"
        }
    }
}


class Chore: NSObject {
    var name : String = ""
    var choreDescription : String = "" //cannot use 'description' as it collides
    var difficulty : Difficulty = Difficulty.easy
    var ageRestrictions : [AgeRestriction] = [AgeRestriction.kid]
    var recurrenceDeadline: RecurrenceDeadline = RecurrenceDeadline.sun
    
    init(name: String, desc: String, difficulty: Difficulty, ageRestrictions: [AgeRestriction]) {
        self.name = name
        self.choreDescription = desc
        self.difficulty = difficulty
        self.ageRestrictions = ageRestrictions
    }
}

