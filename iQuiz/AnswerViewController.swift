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
    let topic = TopicController.sharedInstance
    
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    
    @IBAction func answerPressed(_ sender: Any) {
        nc.post(name: NSNotification.Name(rawValue: "answerSubmit"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let question = topic.getCurrentQuestion()
        
        questionText.text = question.questionText
        answerLabel.text = question.answers![question.correctAnswer!]
        if question.isCorrect(){
            resultLabel.text = "Correct! 😀"
        }else{
            resultLabel.text = "Incorrect 😫"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
