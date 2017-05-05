//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Duncan Andrew on 5/3/17.
//  Copyright © 2017 Duncan Andrew. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    let nc = NotificationCenter.default
    let topic = TopicController.sharedInstance
    
    @IBAction func switchPressed(_ sender: UISwitch) {
        // Iterate through all UISwitches to disable all except the one that was just pressed
        for view in self.view.subviews as [UIView] {
            if let radioSwitch = view as? UISwitch {
                if radioSwitch.tag != sender.tag && radioSwitch.isOn{
                    radioSwitch.setOn(false, animated: true)
                }
            }
        }
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        // If no answer is given we will default to the first for now
        // TODO: Change this later
        var userAnswer = 0
        for view in self.view.subviews as [UIView] {
            if let radioSwitch = view as? UISwitch {
                if radioSwitch.isOn{
                    userAnswer = radioSwitch.tag
                }
            }
        }
        
        topic.setCurrentQuestionUserAnswer(userAnswer)
        
        nc.post(name: NSNotification.Name(rawValue: "questionSubmit"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let question = topic.getCurrentQuestion()
        
        // Set text on the view to the correct question
        for view in self.view.subviews as [UIView]{
            if let label = view as? UILabel{
                // If they label is the question text
                if label.restorationIdentifier == "questionText"{
                    label.text = question.questionText
                }else{
                    label.text = question.answers[label.tag]
                }
            }
        }
        
        // Set all sliders to 0
        for view in self.view.subviews as [UIView] {
            if let radioSwitch = view as? UISwitch {
                radioSwitch.setOn(false, animated: false)
            }
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
