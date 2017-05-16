//
//  TableViewController.swift
//  iQuiz
//
//  Created by Duncan Andrew on 4/28/17.
//  Copyright © 2017 Duncan Andrew. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let topic = TopicController.sharedInstance
    let nc = NotificationCenter.default
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        topic.loadDataFromWeb()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nc.addObserver(self, selector: #selector(topicsRefreshed), name: NSNotification.Name(rawValue: "topicsRefreshed"), object: nil)
        nc.addObserver(self, selector: #selector(downloadError), name: NSNotification.Name(rawValue: "downloadError"), object: nil)
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topic.topics.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TopicTableViewCell

        cell.topicTitle.text = topic.topics[indexPath.row].title
        cell.topicDescr.text = topic.topics[indexPath.row].descr
        cell.imageView?.image = UIImage(named:topic.topics[indexPath.row].iconName!)!
        
        cell.topicDescr.sizeToFit()
        //TODO: Make cell automatically compute height
        // https://www.raywenderlich.com/129059/self-sizing-table-view-cells

        return cell
    }
 
    @IBAction func settingsPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField { (textField) in
            textField.text = self.topic.dataURL
        }
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { [weak alert] (_) in
            let textField = alert!.textFields![0] // Force unwrapping because we know it exists.
            self.topic.dataURL = textField.text!
            self.topic.loadDataFromWeb()
            UserDefaults.standard.set(textField.text!, forKey: "dataURL")
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        topic.topicNumber = indexPath.row
        performSegue(withIdentifier: "questionSegue", sender: self)
    }
    
    func topicsRefreshed(){
        //self.view.setNeedsDisplay()
        self.tableView.reloadData()
        //dispatch_async(dispatch_get_main_queue(), { self.tableView.reloadData() })
        print("refreshed")
    }
    
    func downloadError(){
        let alert = UIAlertController(title: "Error", message: "Questions could not be downloaded from specified url", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    

}
