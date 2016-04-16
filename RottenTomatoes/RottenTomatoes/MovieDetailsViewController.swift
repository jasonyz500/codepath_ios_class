//
//  MovieDetailsViewController.swift
//  RottenTomatoes
//
//  Created by Jason Zhou on 9/12/15.
//  Copyright © 2015 lollerballer. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    
    var movie: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = movie["title"] as? String
        synopsisLabel.text = movie["synopsis"] as? String
        // get url
        if let posters = movie["posters"] as? NSDictionary {
            if let detailed = posters["detailed"] as? String {
                //hack for high res image
                var url = detailed
                let range = url.rangeOfString(".*cloudfront.net/", options: .RegularExpressionSearch)
                if let range = range {
                    url = url.stringByReplacingCharactersInRange(range, withString: "https://content6.flixster.com/")
                    posterView.setImageWithURL(NSURL(string: url)!)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
