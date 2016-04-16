//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Jason Zhou on 9/21/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

import UIKit

protocol FiltersViewControllerDelegate {
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: SearchSettings)
}

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate, BusinessesViewControllerDelegate, DealsCellDelegate, DistanceSelectorCellDelegate, SegmentedControlCellDelegate {

    var searchSettings = SearchSettings()
    @IBOutlet weak var tableView: UITableView!
    var delegate: FiltersViewControllerDelegate?
    
    var categories: [[String: String]]!
    var switchStates = [Int:Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        categories = yelpCategories()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 3:
            return categories.count
        default:
            return 1
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.searchSettings.headers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            // deals
            let cell = tableView.dequeueReusableCellWithIdentifier("DealsCell", forIndexPath: indexPath) as! DealsCell
            cell.switchLabel.text = "Offering a Deal"
            if self.searchSettings.deals != nil {
                cell.onSwitch.on = self.searchSettings.deals!
            } else {
                cell.onSwitch.on = false
            }
            cell.delegate = self
            return cell
        case 1:
            // distance
            let cell = tableView.dequeueReusableCellWithIdentifier("DistanceSelectorCell", forIndexPath: indexPath) as! DistanceSelectorCell
            cell.segmentedPicker.removeAllSegments()
            for var i = 0; i < self.searchSettings.distanceNames.count; i++ {
                cell.segmentedPicker.insertSegmentWithTitle(self.searchSettings.distanceNames[i], atIndex: i, animated: true)
            }
            cell.segmentedPicker.selectedSegmentIndex = self.searchSettings.distance!
            cell.delegate = self
            return cell
            
        case 2:
            //sort by
            let cell = tableView.dequeueReusableCellWithIdentifier("SegmentedControlCell", forIndexPath: indexPath) as! SegmentedControlCell
            cell.segmentedPicker.removeAllSegments()
            for var i = 0; i < self.searchSettings.sortNames.count; i++ {
                cell.segmentedPicker.insertSegmentWithTitle(self.searchSettings.sortNames[i], atIndex: i, animated: true)
            }
            cell.segmentedPicker.selectedSegmentIndex = self.searchSettings.distance!
            cell.delegate = self
            return cell
            
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell", forIndexPath: indexPath) as! SwitchCell
            cell.switchLabel.text = categories[indexPath.row]["name"]
            cell.delegate = self
            
            if switchStates[indexPath.row] != nil {
                cell.onSwitch.on = switchStates[indexPath.row]!
            } else {
                cell.onSwitch.on = false
            }
            return cell
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! HeaderCell
        header.myLabel.text = self.searchSettings.headers[section]
        return header
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 30
        }
    }
    
    //delegates
    
    func switchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
        print("switch")
        let indexPath = tableView.indexPathForCell(switchCell)!
        switchStates[indexPath.row] = value
    }
    
    func distanceSelectorCell(distanceSelectorCell: DistanceSelectorCell, didChangeSelection value: Int) {
        print("distance")
        self.searchSettings.distance = value
    }
    
    func segmentedControlCell(segmentedControlCell: SegmentedControlCell, didChangeSelection value: Int) {
        print("sort")
        self.searchSettings.sort = value
    }
    
    func dealsCell(dealsCell: DealsCell, didChangeValue value: Bool) {
        print("deals")
        self.searchSettings.deals = value
    }

    @IBAction func onCancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onSearchButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
        var selectedCategories = [String]()
        for (row,isSelected) in switchStates {
            if isSelected {
                selectedCategories.append(categories[row]["code"]!)
            }
        }
        
        if selectedCategories.count > 0 {
            self.searchSettings.categories = selectedCategories
        }
        delegate?.filtersViewController(self, didUpdateFilters: self.searchSettings)
    }
    
    func businessesViewController(businessesViewController: BusinessesViewController, didGoFilters filters: SearchSettings) {
        self.searchSettings = filters
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func yelpCategories() -> [[String:String]] {
        return [
        ["name" : "Afghan", "code" : "afghani"],
        ["name" : "Beer Garden", "code" : "beergarden"],
        ["name" : "Buffets", "code" : "buffets"],
        ["name" : "Chinese", "code" : "chinese"],
        ["name" : "German", "code" : "german"],
        ["name" : "Japanese", "code" : "japanese"],
        ["name" : "Ramen", "code" : "ramen"],
        ]
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
