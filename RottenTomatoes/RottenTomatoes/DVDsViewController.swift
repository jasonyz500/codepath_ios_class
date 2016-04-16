//
//  DVDsViewController.swift
//  
//
//  Created by Jason Zhou on 9/13/15.
//
//

import UIKit

private let CELL_NAME = "com.lollerballer.RottenTomatoes.DVDViewCell"

class DVDsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{


    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    var movies:NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        getData(false)
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CELL_NAME, forIndexPath: indexPath) as! DVDViewCell
        if let movie = movies![indexPath.row] as? NSDictionary {
            if let posters = movie["posters"] as? NSDictionary {
                if let detailed = posters["detailed"] as? String {
                    //hack for high res image
                    var url = detailed
                    let range = url.rangeOfString(".*cloudfront.net/", options: .RegularExpressionSearch)
                    if let range = range {
                        url = url.stringByReplacingCharactersInRange(range, withString: "https://content6.flixster.com/")
                    }
                    cell.titleLabel.text = movie["title"] as? String
                    cell.descriptionLabel.text = movie["synopsis"] as? String
                    cell.posterView.setImageWithURL(NSURL(string: url)!)
                }
            }
        }
        return cell
    }
    
    func getData(isRefresh: Bool) {
        //SwiftLoader.show("Loading...", animated: true)
        let url = NSURL(string: "https://gist.githubusercontent.com/timothy1ee/e41513a57049e21bc6cf/raw/b490e79be2d21818f28614ec933d5d8f467f0a66/gistfile1.json")!
        let request = NSMutableURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options:[]) as! NSDictionary
            self.movies = responseDictionary["movies"] as? NSArray
            self.tableView.reloadData()
            if isRefresh {
                self.refreshControl.endRefreshing()
            }
            //SwiftLoader.hide()
        })
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        // do something here
    }
    
    func onRefresh() {
        getData(true)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let vc = segue.destinationViewController as? DVDDetailsViewController
        let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
        vc!.movie = self.movies![indexPath!.row] as? NSDictionary
    }
}
