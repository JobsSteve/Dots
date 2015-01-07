//
//  ItemViewCell.swift
//  Dots
//
//  Created by Kouno, Masayuki on 1/6/15.
//  Copyright (c) 2015 Kouno, Masayuki. All rights reserved.
//

import UIKit

class ItemViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var abstract: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var titleHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(item: Item) {
        if item.title? == nil {
            titleHeight.constant = 0
        } else {
            self.title?.text = item.title            
        }
        self.abstract?.text = item.text
        self.time?.text = Utility.stringFromDate("HH:mm:dd", date: item.date)
        self.userName?.text = item.user?.name
    }
}
