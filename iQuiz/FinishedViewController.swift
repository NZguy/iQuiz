//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by Duncan Andrew on 5/3/17.
//  Copyright © 2017 Duncan Andrew. All rights reserved.
//

import UIKit

class FinishedViewController: UIViewController {

    let nc = NotificationCenter.default
    
    @IBAction func finishPressed(_ sender: Any) {
        nc.post(name: NSNotification.Name(rawValue: "finishSubmit"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
