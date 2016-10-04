//
//  ListViewController.swift
//  GLClub
//
//  Created by Maxi Garcia on 5/10/16.
//  Copyright (c) 2016 Maxi Garcia. All rights reserved.
//

import UIKit

protocol ListViewControllerInput {
    func displayList(_ viewModel: ListViewModel)
    func displayLoadListError()
    func displayFilterList(_ list: [Item])
    func displayList()
    func displayImage(_ image: UIImage, forIndexPath: IndexPath)
    
}

protocol ListViewControllerOutput {
    func loadList(_ request: ListRequest)
    func filterList(_ model: ListViewModel, searhText: String)
    func loadImage(_ forItem: Item, fotIndexPath: IndexPath, withUrl: String)
}

extension ListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

class ListViewController: UIViewController, ListViewControllerInput, UITableViewDelegate, UITableViewDataSource {
    
    var output: ListViewControllerOutput!
    var router: ListRouter!
    var table: UITableView!
    var model: ListViewModel!
    var filterActive = false
    var searchController: UISearchController!
    
    // MARK: Object lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ListConfigurator.sharedInstance.configure(self)
    }
    
    //MARK: Search functions
    
    var filterItems = [Item]()
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        output.filterList(self.model, searhText: searchText.lowercased())
    }
    
    func displayList() {
        self.filterActive = false
        self.table.reloadData()
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "GLClub news"

        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.dimsBackgroundDuringPresentation = false // default is YES

        self.table.tableHeaderView = searchController.searchBar
        self.definesPresentationContext = true
        loadList()
    }
    
    // MARK: Event handling
    
    func loadList() {
        let request = ListRequest()
        output.loadList(request)
    }
    
    // MARK: Display logic
    
    func displayList(_ viewModel: ListViewModel) {
        self.model = viewModel
        self.filterActive = false
        self.table.reloadData()
    }
    
    func displayFilterList(_ list: [Item]) {
        if searchController.isActive {
            self.filterItems = list
            self.filterActive = true
            self.table.reloadData()
        }
    }
    
    func displayLoadListError() {
        
        let alertController = UIAlertController(title: "Error obteniendo información",
                                                message: "No se pudo obtener la lista de noticias de GLClub",
                                                preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction( UIAlertAction(title: "Dismiss",
            style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: tableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.filterActive {
            return filterItems.count
        }
        
        if self.model != nil {
            return self.model.items.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        var message: String = ""
        
        if self.model != nil {
            var numberOfRowInsection = self.model.items.count
            
            if self.filterActive {
                numberOfRowInsection = filterItems.count
            }
            
            if numberOfRowInsection == 0 {
                message = "No hay noticias disponibles"
            }
        }
        return message
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as? ListCell
        let item = self.getItem(indexPath)
        
        cell!.titleLbl.text = item.title
        cell!.descriptionLbl.text = item.description
        cell!.byLbl.text = "By: " + item.creator
        cell!.dateLbl.text =  item.pubDate
        
        if item.image  == nil && item.imageURL != nil {
            self.output.loadImage(item, fotIndexPath: indexPath, withUrl: item.imageURL!)
        } else if item.image != nil {
            cell!.thumbnailView.image = item.image
        }
        
        return cell!
    }
    
    func displayImage(_ image: UIImage, forIndexPath: IndexPath) {
        let item = self.getItem(forIndexPath)
        item.image = image
        let cell = self.table.cellForRow(at: forIndexPath) as? ListCell
        cell?.thumbnailView.image = item.image
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.getItem(indexPath)
        self.router.navigateToDetail(item)
    }
    
    //MARK utilities
    
    func getItem(_ indexPath: IndexPath) -> Item {
        if self.filterActive {
            return self.filterItems[(indexPath as NSIndexPath).row]
        } else {
            return self.model.items[(indexPath as NSIndexPath).row]
        }
    }
}
