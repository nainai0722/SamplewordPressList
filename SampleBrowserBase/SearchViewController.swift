//
//  SearchViewController.swift
//  SampleBrowserBase
//
//  Created by apple on 2018/09/18.
//  Copyright © 2018年 com.nainai0722. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let searchResultViewController = SearchResultTableViewController()
        
        searchController = UISearchController(searchResultsController: searchResultViewController)

        
        
        self.definesPresentationContext = true
        
        self.navigationItem.searchController = searchController
        self.title = "検索"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
        
        searchController.searchBar.delegate = searchResultViewController
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
