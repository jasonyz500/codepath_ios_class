//
//  SearchSettings.swift
//  Yelp
//
//  Created by Jason Zhou on 9/21/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

import Foundation


class SearchSettings {
    var searchString: String?
    var deals: Bool?
    
    let distanceOptions: [(String, Int)] = [("Auto", 0), ("500m", 500), ("1km", 1000), ("3km", 3000)]
    var distance: Int?
    var distanceNames: [String] = []

    var categoriesOptions : [[String:String]] = [
        ["name" : "Afghan", "code" : "afghani"],
        ["name" : "Beer Garden", "code" : "beergarden"],
        ["name" : "Buffets", "code" : "buffets"],
        ["name" : "Chinese", "code" : "chinese"],
        ["name" : "German", "code" : "german"],
        ["name" : "Japanese", "code" : "japanese"],
        ["name" : "Ramen", "code" : "ramen"],
    ]
    var categories: [String]?
    
    let sortOptions: [(String, Int)] = [("Best Match", 0), ("Distance", 1), ("Highest Rated", 2)]
    var sort: Int?
    var sortNames: [String] = []
    
    let headers = ["","Distance", "Sort By", "Category"]
    
    init() {
        for v in distanceOptions {
            self.distanceNames.append(v.0)
        }
        self.distance = 0
        for v in sortOptions {
            self.sortNames.append(v.0)
        }
        self.sort = 0
    }

}
