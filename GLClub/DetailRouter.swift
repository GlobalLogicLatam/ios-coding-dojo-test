//
//  DetailRouter.swift
//  GLClub
//
//  Created by Maxi Garcia on 5/11/16.
//  Copyright (c) 2016 Maxi Garcia. All rights reserved.
//

import UIKit

protocol DetailRouterInput {
    func navigateToSomewhere()
}

class DetailRouter: DetailRouterInput {
    weak var viewController: DetailViewController!
    
    // MARK: Navigation
    
    func navigateToSomewhere() {
        
    }
}
