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

    @IBOutlet weak var serviceIcon: UIImageView!
    @IBOutlet weak var userIcon: UIImageView!

    @IBOutlet weak var titleHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        serviceIcon.clipToCircle()
        userIcon.clipToCircle()
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.solarizedAlphaGreen()
        self.selectedBackgroundView = backgroundView
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(item: Item) {
        if item.title? == nil {
            self.title?.text = ""
            titleHeight.constant = 0
        } else {
            self.title?.text = item.title            
            titleHeight.constant = 40
        }
        self.setAbstract(item.text)
        self.time?.text = Utility.stringFromDate("HH:mm", date: item.created_at)
        self.userName?.text = item.user?.name
        if let url = item.user?.picture {
            userIcon.loadImageAsync(url)
        } else {
            userIcon.image = nil
        }
        serviceIcon.image = UIImage(named: "twitter")
    }
    
    func setAbstract(string: String?) {
        if let string = string {
            var paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            var attrString = NSMutableAttributedString(string: string)
            attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
            abstract.attributedText = attrString
        } else {
            abstract.text = ""
        }
    }
}
