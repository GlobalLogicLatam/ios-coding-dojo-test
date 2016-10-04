//
//  DetailConfigurator.swift
//  GLClub
//
//  Created by Maxi Garcia on 5/11/16.
//  Copyright (c) 2016 Maxi Garcia. All rights reserved.
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension DetailViewController: DetailPresenterOutput {}

extension DetailInteractor: DetailViewControllerOutput {}

extension DetailPresenter: DetailInteractorOutput {}

class DetailConfigurator {
    
    // MARK: Object lifecycle
    
    static var sharedInstance = DetailConfigurator()
    
    fileprivate init() {}
    
    // MARK: Configuration
    
    func configure(_ viewController: DetailViewController) {
        let router = DetailRouter()
        router.viewController = viewController
        
        let presenter = DetailPresenter()
        presenter.output = viewController
        
        let interactor = DetailInteractor()
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
    }
}
