//
//  RssItemModel.swift
//  rss-reader
//
//  Created by Svyatoslav Titov on 25.03.2018.
//  Copyright © 2018 Svyatoslav Titov. All rights reserved.
//

import UIKit

class RssItemModel {
    
    init() {
    }
    
    init?(dictionary: [String : String]) {
        guard let title = dictionary["title"],
          let description = dictionary["description"],
          let link = dictionary["link"],
          let guid = dictionary["guid"],
          let category = dictionary["category"],
            let pubDate = dictionary["pubDate"] else {
                return nil
        }
        
        self.title = title
        self.description = description
        self.link = link
        self.guid = guid
        self.category = category
        self.pubDate = pubDate
    }
    
    var title: String?
    var description: String?
    var link: String?
    var guid: String?
    var category: String?
    var pubDate: String?
}
