//
//  ListInteractor.swift
//  GLClub
//
//  Created by Maxi Garcia on 5/10/16.
//  Copyright (c) 2016 Maxi Garcia. All rights reserved.
//

import UIKit

protocol ListInteractorInput {
    func loadList(_ request: ListRequest)
    func filterList(_ model: ListViewModel, searhText: String)
    func loadImage(_ forItem: Item, fotIndexPath: IndexPath, withUrl: String)
}

protocol ListInteractorOutput {
    func presentList (_ response: ListResponse)
    func presentLoadListError()
    func presentFilterList(_ list: [Item])
    func presentListFromModel()
    func presentImage(_ image: UIImage, forIndexPath: IndexPath)
}

class ListInteractor: ListInteractorInput {
    var  output: ListInteractorOutput!
    var worker: ListWorkerProtocol!
    
    // MARK: Business logic
    
    func filterList(_ model: ListViewModel, searhText: String) {
        var filterItems = [Item]()
        
        
        let trimmedString = searhText.trimmingCharacters(
            in: CharacterSet.whitespacesAndNewlines
        )
        
        if trimmedString.characters.count > 2 {
            filterItems = model.items.filter { item in
                return item.title.lowercased().contains(trimmedString.lowercased())
            }
            output.presentFilterList(filterItems)
            
        } else {
            output.presentListFromModel()
        }
    }
    
    func loadImage(_ forItem: Item, fotIndexPath: IndexPath,
                   withUrl: String) {
        
        worker.getImage(withUrl, success: {
            image in
            self.output.presentImage(image, forIndexPath:fotIndexPath)
            
            }, fail: { err in
                print(err)
                print("No se pudo cargar la imagen para la url: " + withUrl)
        })
    }
    
    func loadList(_ request: ListRequest) {
        
        worker.getList({ result in
            self.output.presentList(result)
            },
                       fail: {
                        self.output.presentLoadListError()
        })
    }
}
