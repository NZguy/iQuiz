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
    let topic = TopicController.sharedInstance
    
    @IBOutlet weak var resultDescrLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func finishPressed(_ sender: Any) {
        nc.post(name: NSNotification.Name(rawValue: "finishSubmit"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let numberCorrect = topic.getCurrentTopic().getNumberCorrect()
        let numberOfQuestions = topic.getCurrentTopic().questions!.count
        
        scoreLabel.text = "\(numberCorrect) of \(numberOfQuestions) correct."
        
        var resultText = ""
        if numberCorrect == numberOfQuestions{
            resultText = "Perfect!"
        }else if numberCorrect == (numberOfQuestions - 1){
            resultText = "Almost Perfect"
        }else if numberCorrect == 0{
            resultText = "Darn"
        }else{
            resultText = "Good Job"
        }
        resultDescrLabel.text = resultText
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
