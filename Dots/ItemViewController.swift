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
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        var deleteAction = UITableViewRowAction(style: .Default, title: "Delete") {
            (action, indexPath) -> Void in
            tableView.editing = false
            println("Delete")
        }
        deleteAction.backgroundColor = UIColor(red: 220.0/255.0, green: 50.0/255.0, blue: 47.0/255.0, alpha: 1.0)
        return [deleteAction]
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }

}

