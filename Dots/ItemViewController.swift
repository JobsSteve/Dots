//
//  ItemViewController.swift
//  Dots
//
//  Created by knmsyk on 12/31/14.
//  Copyright (c) 2014 knmsyk. All rights reserved.
//

import UIKit
import CoreData

class ItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items: [Item] = []
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fetchData()
        
        let delegate = UIApplication.sharedApplication().delegate as AppDelegate
        let className = "Item"
        var error: NSError?
        let fetchRequest = NSFetchRequest(entityName:className)
        var sorter: NSSortDescriptor = NSSortDescriptor(key: "date" , ascending: false)
        fetchRequest.sortDescriptors = [sorter]
        self.items = delegate.managedObjectContext!.executeFetchRequest(fetchRequest, error: &error) as [Item]
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchData() {
        let lastFetchKey = "last_fetch_date"
        let date = NSUserDefaults.standardUserDefaults().objectForKey(lastFetchKey) as NSDate?
        if date?.compare(3.hours.ago) == NSComparisonResult.OrderedDescending {
            return
        }
        
        DotsFetcher.fetch()
        
        NSUserDefaults.standardUserDefaults().setObject(NSDate(), forKey:lastFetchKey)
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
 
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: ItemViewCell = tableView.dequeueReusableCellWithIdentifier("ItemViewCell") as ItemViewCell
        let item = self.items[indexPath.row]
        cell.configureCell(item)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
    }
}

