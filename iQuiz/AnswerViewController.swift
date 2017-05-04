//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Duncan Andrew on 5/3/17.
//  Copyright © 2017 Duncan Andrew. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {

    let nc = NotificationCenter.default
    
    @IBAction func answerPressed(_ sender: Any) {
        nc.post(name: NSNotification.Name(rawValue: "answerSubmit"), object: nil)
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
