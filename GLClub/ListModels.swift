//
//  GLListModels.swift
//  GLClub
//
//  Created by Maxi Garcia on 5/10/16.
//  Copyright (c) 2016 Maxi Garcia. All rights reserved.
//

import UIKit
import SWXMLHash

struct ListRequest {
    
}

class Item {
    var title: String!
    var description: String!
    var content: String!
    var creator: String!
    var pubDate: String!
    var imageURL: String?
    var image: UIImage?
    
    
    init (
        title: String,
        description: String,
        content: String,
        creator: String,
        pubDate: String,
        imageURL: String) {
        
        self.title = title
        self.description = description
        self.content = content
        self.creator = creator
        self.pubDate = pubDate
        self.imageURL = imageURL
    }
    
    init(fromXml: XMLIndexer) {
        
        self.title = self.getProperty(fromXml, withName: "title")
        
        let attrStr: NSAttributedString?
        do {
            let data = self.getProperty(fromXml, withName: "description").data(using: String.Encoding.isoLatin1, allowLossyConversion: true)
            let options = [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType]
            attrStr = try NSAttributedString(data: data!,
                                             options: options,
                                             documentAttributes: nil)
        } catch _ {
            attrStr = nil
            print("Error: couldn't parse")
        }
        
        self.description = attrStr!.string
        self.content = self.getProperty(fromXml, withName: "content:encoded")
        self.creator = self.getProperty(fromXml, withName: "dc:creator").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        let pubDateString = self.getProperty(fromXml, withName: "pubDate")
        let pubDate = pubDateString.dateFromRFC822String()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy HH:mm"
        self.pubDate = formatter.string(from: pubDate!)
        self.setImageURL(fromXml)
    }
    
    func getProperty(_ fromXml: XMLIndexer,
                     withName: String) -> String {
        return fromXml[withName].element!.text!
    }
    
    func setImageURL(_ fromXml: XMLIndexer) {
        do {
            self.imageURL = try fromXml.byKey("media:thumbnail").element?.allAttributes["url"]?.text
        } catch {
            print("Nothing to do")
        }
    }
}

class ListResponse {
    
    var items: [Item]!
    
    init() {
        items = []
    }
    
    init(withItems: [Item]) {
        self.items = withItems
    }
    
    init(fromXml: String) {
        items = []
        let xmlIndex = SWXMLHash.parse(fromXml)
        
        for elem in xmlIndex["rss"]["channel"]["item"] {
            let item = Item(fromXml: elem)
            self.items.append(item)
        }
    }
}

struct ListViewModel {
    var items: [Item]
}
