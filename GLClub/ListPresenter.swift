//
//  ListPresenter.swift
//  GLClub
//
//  Created by Maxi Garcia on 5/10/16.
//  Copyright (c) 2016 Maxi Garcia. All rights reserved.
//

import UIKit

protocol ListPresenterInput {
    func presentList(_ response: ListResponse)
    func presentLoadListError()
    func presentFilterList(_ list: [Item])
    func presentListFromModel()
    func presentImage(_ image: UIImage, forIndexPath: IndexPath)
}

protocol ListPresenterOutput: class {
    func displayList(_ viewModel: ListViewModel)
    func displayLoadListError()
    func displayList()
    func displayImage(_ image: UIImage, forIndexPath: IndexPath)
    func displayFilterList(_ list: [Item])
}

class ListPresenter: ListPresenterInput {
    weak var output: ListPresenterOutput!
    
    // MARK: Presentation logic

    func presentList(_ response: ListResponse) {
        let viewModel = ListViewModel( items: response.items)
        output.displayList(viewModel)
    }
    
    func presentLoadListError() {
        output.displayLoadListError()
    }
    
    func presentFilterList(_ list: [Item]) {
        output.displayFilterList(list)
    }

    func presentListFromModel() {
        output.displayList()
    }
    
    func presentImage(_ image: UIImage, forIndexPath: IndexPath) {
        output.displayImage(image, forIndexPath: forIndexPath)
    }
}
