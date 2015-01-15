//
//  ItemViewController.swift
//  Dots
//
//  Created by knmsyk on 12/31/14.
//  Copyright (c) 2014 knmsyk. All rights reserved.
//

import UIKit
import CoreData
import Timepiece

class ItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items: [Item] = []
    let app = UIApplication.sharedApplication().delegate as AppDelegate
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    var _fetchedResultsController: NSFetchedResultsController? = nil
    var fetchedResultsController: NSFetchedResultsController {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        // get start day and last day for request predicate
        let format = "yyyy/MM/dd HH:mm:ss"
        let days: [NSDate] = [
            7.days.ago.beginningOfDay,
            NSDate.today().endOfDay
        ]
        
        // get coredata instances
        let sort: NSSortDescriptor = NSSortDescriptor(key: "created_at", ascending: false)
        let predicate: NSPredicate? = NSPredicate(format: "created_at >= %@ && created_at < %@", days[0], days[1])
        
        let request = NSFetchRequest(entityName: "Item")
        request.predicate = predicate
        request.sortDescriptors = [sort]
        request.returnsObjectsAsFaults = false
        
        // get an instance of NSFetchedResultsController
        let context: NSManagedObjectContext? = app.cdh.managedObjectContext
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context!, sectionNameKeyPath: "date", cacheName: nil)
        _fetchedResultsController = aFetchedResultsController
        
        var error: NSError? = nil
        if !_fetchedResultsController!.performFetch(&error) {
            abort()
        }
        return _fetchedResultsController!
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
        
    // MARK: - UITableViewDelegate, UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sections = self.fetchedResultsController.sections as [NSFetchedResultsSectionInfo]
        return sections[section].numberOfObjects
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let infos = self.fetchedResultsController.sections as? [NSFetchedResultsSectionInfo] {
            return infos.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: ItemViewCell = tableView.dequeueReusableCellWithIdentifier("ItemViewCell") as ItemViewCell
        let item = self.fetchedResultsController.objectAtIndexPath(indexPath) as Item
        cell.configureCell(item)
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let info = self.fetchedResultsController.sections as? [NSFetchedResultsSectionInfo] {
            return info[section].name!
        }
        return ""
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let view = view as UITableViewHeaderFooterView
        view.contentView.backgroundColor = SorarizedColors.Base2
        view.textLabel.textColor = SorarizedColors.Base02
        view.textLabel.font = UIFont(name: "Arial", size: 14)
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
        deleteAction.backgroundColor = SorarizedColors.Red
        return [deleteAction]
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
}

