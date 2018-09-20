//
//  SearchResultTableViewController.swift
//  SampleBrowserBase
//
//  Created by apple on 2018/09/18.
//  Copyright © 2018年 com.nainai0722. All rights reserved.
//

import UIKit
import SafariServices

class SearchResultTableViewController: UITableViewController,
UISearchBarDelegate {
    var dataList: [SampleModel] = []
//    func updateSearchResults(for searchController: UISearchController) {
//        if let text = searchController.searchBar.text {
//            self.reloadListDatas(text)
//        }
//    }

    func searchBar(_ searchBar: UISearchBar, shouldChangeTextInrange: NSRange, replacementText text: String) -> Bool {
        
        self.dataList = []
        self.tableView.reloadData()
        return true
        

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        reloadListDatas(searchBar.text!)
        
    }
    
    func reloadListDatas(_ text: String) {
        if text.isEmpty {
            return
        }
        
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
        
        let urlString = "https://demo.wp-api.org/wp-json/wp/v2/posts/" + "?search=" + text
        
        let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!)!
        
        let task = session.dataTask(with: url){(data,response, error)in
            
            
            if error != nil {
                let controller : UIAlertController = UIAlertController(title: nil, message: "エラーが発生しました", preferredStyle: UIAlertControllerStyle.alert)
                controller.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                self.present(controller,animated:true, completion: nil)
                return
            }
            
            guard let jsonData : Data = data else{
                let controller : UIAlertController = UIAlertController(title: nil, message: "エラーが発生しました", preferredStyle: UIAlertControllerStyle.alert)
                
                controller.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                self.present(controller, animated: true, completion: nil)
                return
            }
            
            self.dataList = try! JSONDecoder().decode([SampleModel].self, from:  jsonData)
            
            DispatchQueue.main.async {
                
                if self.dataList.isEmpty {
                    let controller : UIAlertController = UIAlertController(title: nil, message: "検索結果がありませんんでした", preferredStyle: UIAlertControllerStyle.alert)
                    controller.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.cancel, handler: nil))
                    self.present(controller, animated:true,completion: nil)
                    return
                }
                
                self.tableView.reloadData()
            }
        }
        task.resume()
            
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let nib = UINib(nibName: "NewsCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "NewsCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsCell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        

        let data = dataList[indexPath.row]
        cell.dataLabel.text = data.dateString
        cell.titleLabel.text = data.title.rendered
        
        // Configure the cell...

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let data = dataList[indexPath.row]
        if let url = URL(string: data.link) {
            let controller: SFSafariViewController = SFSafariViewController(url: url)
            self.present(controller, animated:true, completion: nil)
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
