//
//  NewsViewController.swift
//  SampleBrowserBase
//
//  Created by apple on 2018/09/16.
//  Copyright © 2018年 com.nainai0722. All rights reserved.
//

import UIKit
import SafariServices

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var dataList:[SampleModel] = []
    
    let refreshControl:UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "NewsCell", bundle: nil)
        
        tableView.register(nib, forCellReuseIdentifier: "NewsCell")
        
        reloadListDatas()
        
        self.navigationItem.title = "最新記事"
        
        if #available(iOS 11, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationItem.largeTitleDisplayMode = .automatic
        }else{
            
        }
        
        refreshControl.addTarget(self, action:  #selector(self.refreshReload(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
        // Do any additional setup after loading the view.
    }

    @IBAction func onNotificationSettingButtonTapped(_ sender: UIBarButtonItem) {
        //通知画面へ遷移する処理を追加
        performSegue(withIdentifier: "MoveNotificationSettingView", sender: nil)
    }
    
    @objc func refreshReload(_ sender:UIRefreshControl) {
        self.reloadListDatas()
    }
    func reloadListDatas() {
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
        
        let url = URL(string: "https://demo.wp-api.org/wp-json/wp/v2/posts/")
        
        let task = session.dataTask(with: url!){(data,response,error)in
            
            if error != nil {
                
                DispatchQueue.main.async {
                    if self.refreshControl.isRefreshing {
                        self.refreshControl.endRefreshing()
                    }
                let controller: UIAlertController = UIAlertController(title: nil, message: "エラー発生", preferredStyle: UIAlertControllerStyle.alert)
                controller.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                self.present(controller, animated: true, completion:nil)
                
                }
                return
            }
            guard let jsonData : Data = data else {
                DispatchQueue.main.async {
                    if self.refreshControl.isRefreshing {
                        self.refreshControl.endRefreshing()
                    }
                    let controller :UIAlertController = UIAlertController(title: nil, message: "エラー発生した", preferredStyle: UIAlertControllerStyle.alert)
                    controller.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                    self.present(controller,animated: true,completion: nil)
                    
                }
                    return
            }
            
            self.dataList = try! JSONDecoder().decode([SampleModel].self, from: jsonData)
                
                
            DispatchQueue.main.async {
                
                if self.refreshControl.isRefreshing {
                    self.refreshControl.endRefreshing()
                }
                self.tableView.reloadData()
            }
        }

        task.resume()
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsCell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for:  indexPath)
            as! NewsCell
        let data = dataList[indexPath.row]
        
        cell.dataLabel.text = data.dateString
        cell.titleLabel.text = data.title.rendered
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let data = dataList[indexPath.row]
        
        if let url = URL(string: data.link){
            let controller: SFSafariViewController = SFSafariViewController(url: url)
            
            self.present(controller, animated: true, completion: nil)
            
        }
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
