//
//  QuestionManagerViewController.swift
//  iQuiz
//
//  Created by Duncan Andrew on 5/3/17.
//  Copyright © 2017 Duncan Andrew. All rights reserved.
//

import UIKit

class QuestionManagerViewController: UIViewController {

    let nc = NotificationCenter.default
    let topic = TopicController.sharedInstance
    
    var questionVC: QuestionViewController!
    var answerVC: AnswerViewController!
    var finishVC: FinishedViewController!
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
        questionVC = nil
        answerVC = nil
        finishVC = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        buildChildren()
        transitionViews(from: nil, to: questionVC)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nc.addObserver(self, selector: #selector(questionSubmitted), name: NSNotification.Name(rawValue: "questionSubmit"), object: nil)
        nc.addObserver(self, selector: #selector(answerSubmitted), name: NSNotification.Name(rawValue: "answerSubmit"), object: nil)
        nc.addObserver(self, selector: #selector(finishSubmitted), name: NSNotification.Name(rawValue: "finishSubmit"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        topic.reset()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func transitionViews(from: UIViewController?, to: UIViewController){
        
        // TODO: Find a better animation
        // https://www.raywenderlich.com/110536/custom-uiviewcontroller-transitions
        UIView.beginAnimations("View Transition", context: nil)
        UIView.setAnimationDuration(0.4)
        UIView.setAnimationCurve(.easeInOut)
        UIView.setAnimationTransition(.flipFromRight, for: view, cache: true)
        
        to.view.frame = view.frame
        
        // Remove view controller and view
        if from != nil{
            from!.willMove(toParentViewController: nil)
            from!.view.removeFromSuperview()
            from!.removeFromParentViewController()
        }
            
        // Add view controller and view
        self.addChildViewController(to)
        self.view.insertSubview(to.view, at: 0)
        to.didMove(toParentViewController: self)
        
        UIView.commitAnimations()
    }
    
    func buildChildren(){
        if questionVC == nil{
            questionVC = storyboard?.instantiateViewController(withIdentifier: "question") as! QuestionViewController
        }
        if answerVC == nil{
            answerVC = storyboard?.instantiateViewController(withIdentifier: "answer") as! AnswerViewController
        }
        if finishVC == nil{
            finishVC = storyboard?.instantiateViewController(withIdentifier: "finish") as! FinishedViewController
        }
    }
    
    func questionSubmitted(){
        transitionViews(from: questionVC, to: answerVC)
    }
    
    func answerSubmitted(){
        if !topic.isLastQuestion(){
            topic.setQuestionNum(topic.getQuestionNum() + 1)
            transitionViews(from: answerVC, to: questionVC)
        }else{
            transitionViews(from: answerVC, to: finishVC)
        }
    }
    
    func finishSubmitted(){
        topic.reset()
        _ = navigationController?.popViewController(animated: true)
    }

}
