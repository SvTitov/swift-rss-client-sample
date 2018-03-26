//
//  RssItemCell.swift
//  rss-reader
//
//  Created by Svyatoslav Titov on 22.03.2018.
//  Copyright © 2018 Svyatoslav Titov. All rights reserved.
//

import UIKit

class RssItemCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var textbody: UITextView!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
