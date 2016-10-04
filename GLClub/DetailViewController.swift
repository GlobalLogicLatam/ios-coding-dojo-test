//
//  DetailViewController.swift
//  GLClub
//
//  Created by Maxi Garcia on 5/11/16.
//  Copyright (c) 2016 Maxi Garcia. All rights reserved.
//

import UIKit

protocol DetailViewControllerInput {
    func displayDetail(_ viewModel: DetailViewModel)
}

protocol DetailViewControllerOutput {
    func loadContent(_ request: DetailRequest)
}

class DetailViewController: UIViewController, DetailViewControllerInput {
    var output: DetailViewControllerOutput!
    var router: DetailRouter!
    var model: Item!
    
    @IBOutlet var webView: UIWebView!
    
    // MARK: Object lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        DetailConfigurator.sharedInstance.configure(self)
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareModel()
    }
    
    // MARK: Event handling
    
    func prepareModel() {
        let request = DetailRequest(item: self.model)
        output.loadContent(request)
    }
    
    // MARK: Display logic
    
    func displayDetail(_ viewModel: DetailViewModel) {
        self.title = viewModel.title
        webView.loadHTMLString(viewModel.content, baseURL: nil)
    }
}
