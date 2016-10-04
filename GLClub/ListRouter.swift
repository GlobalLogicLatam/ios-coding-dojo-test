//
//  ListRouter.swift
//  GLClub
//
//  Created by Maxi Garcia on 5/10/16.
//  Copyright (c) 2016 Maxi Garcia. All rights reserved.
//

import UIKit

protocol ListRouterInput {
    func navigateToList(_ window: UIWindow)
    func navigateToDetail(_ model: Item)
}

class ListRouter: ListRouterInput {
    weak var viewController: ListViewController!
    
    // MARK: Navigation
    
    func navigateToList(_ window: UIWindow) {
        let storyboard = UIStoryboard(name: "ListView", bundle: nil)
        window.rootViewController = storyboard.instantiateInitialViewController()!
    }
    
    func navigateToDetail(_ model: Item) {
        let storyboard = UIStoryboard(name: "DetailView", bundle: nil)
        let detailViewController = storyboard.instantiateInitialViewController()! as? DetailViewController
        
        detailViewController!.model = model
        viewController.navigationController?.pushViewController(detailViewController!, animated: true)
    }
}
