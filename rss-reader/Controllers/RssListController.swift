//
//  RssListController.swift
//  rss-reader
//
//  Created by Svyatoslav Titov on 22.03.2018.
//  Copyright © 2018 Svyatoslav Titov. All rights reserved.
//

import UIKit
import Alamofire

class RssListController: UITableViewController, XMLParserDelegate {

    @IBOutlet weak var rssList: UITableView!
    var refresher: UIRefreshControl!
    
    var rssItems = [RssItemModel]()
    var itemTitle = String()
    var itemDescription = String()
    var itemDate = String()
    var elemtName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refresher = UIRefreshControl()
        rssList.addSubview(refresher)
        refresher.attributedTitle = NSAttributedString(string: "Refresh!")
        refresher.addTarget(self, action: #selector(fetchRss), for: .valueChanged)
        
        fetchRss()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rssItems.count
    }

    @objc func fetchRss(){
        let settings = UserDefaults.standard
        if let url = settings.string(forKey: "UrlAddress"){
            Alamofire.request(url)
                .responseString { response in
                    
                    let parser = XMLParser(data: response.result.value!.data(using: String.Encoding.utf8)!)
                    parser.delegate = self
                    parser.parse()
                    self.rssList.reloadData()
            }
        }
        
        refresher.endRefreshing()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RssItem", for: indexPath) as! RssItemCell

        let item = rssItems[indexPath.row]
        cell.title?.text = item.title!
        cell.textbody?.text = item.description!
        cell.date?.text = item.pubDate!
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        self.elemtName = elementName
        
        if (elementName == "item"){
            self.itemTitle = String()
            self.itemDescription = String()
            self.itemDate = String()
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName == "item") {
            let rssItem = RssItemModel()
            rssItem.title = itemTitle
            rssItem.description = itemDescription
            rssItem.pubDate = itemDate
            
            rssItems.append(rssItem)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        let data = string.trimmingCharacters(in: .whitespacesAndNewlines)
        if (!data.isEmpty) {
            if self.elemtName == "title"{
                self.itemTitle += data
            } else if (self.elemtName == "description"){
                self.itemDescription += data
            } else if (self.elemtName == "pubDate"){
                self.itemDate += data
            }
        }
    }
}
