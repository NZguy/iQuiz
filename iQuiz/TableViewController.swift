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
    
    struct Topic{
        var title : String
        var descr : String
        var iconName : String
    }
    
    let topics = [
        Topic(title: "Mathmatics",
        descr: "Mathematics is the study of topics such as quantity, structure, space, and change. There is a range of views among mathematicians and philosophers as to the exact scope and definition of mathematics.",
        iconName: "math"),
        Topic(title: "Marvel",
        descr: "Marvel Comics is the common name and primary imprint of Marvel Worldwide Inc., formerly Marvel Publishing, Inc. and Marvel Comics Group, an American publisher of comic books and related media.",
        iconName: "hero"),
        Topic(title: "Science",
        descr: "Science is a systematic enterprise that builds and organizes knowledge in the form of testable explanations and predictions about the universe.",
        iconName: "science")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TopicTableViewCell

        cell.topicTitle.text = topics[indexPath.row].title
        cell.topicDescr.text = topics[indexPath.row].descr
        cell.imageView?.image = UIImage(named:topics[indexPath.row].iconName)!
        
        cell.topicDescr.sizeToFit()
        //TODO: Make cell automatically compute height
        // https://www.raywenderlich.com/129059/self-sizing-table-view-cells

        return cell
    }
 
    @IBAction func settingsPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        topic.topicNumber = indexPath.row
        performSegue(withIdentifier: "questionSegue", sender: self)
    }

    

}
