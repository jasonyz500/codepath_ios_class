//
//  MoviesViewController.swift
//  RottenTomatoes
//
//  Created by Jason Zhou on 9/12/15.
//  Copyright © 2015 lollerballer. All rights reserved.
//

import UIKit
import JGProgressHUD

private let CELL_NAME = "com.lollerballer.RottenTomatoes.MovieViewCell"

class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var refreshControl: UIRefreshControl!
    var movies:NSArray?
    var filtered:NSArray?
    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var searchBar: UISearchBar!
    var searchActive : Bool = false
    var hud: JGProgressHUD = JGProgressHUD()
    var connectionError : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
//        searchBar.delegate = self
        
        getData(false)
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies?.count ?? 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CELL_NAME, forIndexPath: indexPath) as! MovieViewCell
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
        self.hud.textLabel.text = "Loading..."
        self.hud.showInView(self.tableView)
        let url = NSURL(string: "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=azx4yy67n4pf5x6h88x36fjt")!
        let request = NSMutableURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            dispatch_async(dispatch_get_main_queue()) {
            if error == nil {
                self.connectionError = false
                let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options:[]) as! NSDictionary
                self.movies = responseDictionary["movies"] as? NSArray
                self.tableView.reloadData()
                if isRefresh {
                    self.refreshControl.endRefreshing()
                }
                self.hud.dismissAfterDelay(1)
            } else {
                print("could not connect")
                self.connectionError = true
                self.hud.dismissAfterDelay(1)
                if isRefresh {
                    self.refreshControl.endRefreshing()
                }
                self.tableView.reloadData()
            }
            }
        })
        task.resume()
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCellWithIdentifier("com.lollerballer.RottenTomatoes.ConnectionErrorCell") as! ConnectionErrorCell
        return headerCell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.connectionError {
            return 38
        } else {
            return 0
        }
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
    
    // search bar functions
//    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
//        var filtered:[NSDictionary] = []
//        for movie:NSDictionary in self.movies! {
//            let title = movie["title"] as! NSString
//            let range = title.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
//            if range != nil {
//                filtered.append(movie)
//            }
//        }
//        
//        if(filtered.count == 0){
//            searchActive = false;
//        } else {
//            searchActive = true;
//        }
//        self.movies = filtered as! NSArray
//        self.tableView.reloadData()
//    }
//    
//    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
//        searchActive = true;
//    }
//    
//    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
//        searchActive = false;
//    }
//    
//    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
//        searchActive = false;
//    }
//    
//    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
//        searchActive = false;
//    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let vc = segue.destinationViewController as? MovieDetailsViewController
        let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
        vc!.movie = self.movies![indexPath!.row] as? NSDictionary
    }
}
