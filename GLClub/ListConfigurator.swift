//
//  ListConfigurator.swift
//  GLClub
//
//  Created by Maxi Garcia on 5/10/16.
//  Copyright (c) 2016 Maxi Garcia. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension ListViewController: ListPresenterOutput {}

extension ListInteractor: ListViewControllerOutput {}

extension ListPresenter: ListInteractorOutput {}

class ListConfigurator {
    
    // MARK: Object lifecycle
    
    static var sharedInstance = ListConfigurator()
    
    fileprivate init() {}
    
    // MARK: Configuration
    
    func configure(_ viewController: ListViewController) {
        let router = ListRouter()
        router.viewController = viewController
        
        let presenter = ListPresenter()
        presenter.output = viewController
        
        let interactor = ListInteractor()
        interactor.output = presenter
        interactor.worker = ListWorker()
        
        viewController.output = interactor
        viewController.router = router
    }
}
