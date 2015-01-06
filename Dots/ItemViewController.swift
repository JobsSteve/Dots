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
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        DotsFetcher.fetch()
        
        let delegate = UIApplication.sharedApplication().delegate as AppDelegate
        let className = "Item"
        var error: NSError?
        let fetchRequest = NSFetchRequest(entityName:className)
        var sorter: NSSortDescriptor = NSSortDescriptor(key: "date" , ascending: false)
        fetchRequest.sortDescriptors = [sorter]
        let results = delegate.managedObjectContext!.executeFetchRequest(fetchRequest, error: &error)
        for resultItem in results! {
            self.items.append(resultItem as Item)
        }
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        let item = self.items[indexPath.row]
        if item.text != nil {
            cell.textLabel.text = item.text
        } else {
            cell.textLabel.text = ""
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
    }
}

