//
//  TopicController.swift
//  iQuiz
//
//  Created by Duncan Andrew on 5/3/17.
//  Copyright © 2017 Duncan Andrew. All rights reserved.
//

import UIKit

class TopicController: NSObject {
    
    struct Topic{
        var title : String
        var descr : String
        var iconName : String
        var questions : [Question]
    }
    
    struct Question{
        var questionText : String
        var correctAnswer : Int
        var userAnswer : Int?
        var answers : [String]
    }
    
    let mathQuestions = [
        Question(
            questionText: "What is 2+2?",
            correctAnswer: 0,
            userAnswer: nil,
            answers: [
                "4",
                "22",
                "An irrational number",
                "Nobody knows"])
    ]
    
    let marvelQuestions = [
        Question(
            questionText: "Who is Iron Man?",
            correctAnswer: 0,
            userAnswer: nil,
            answers: [
                "Tony Stark",
                "Obadiah Stane",
                "A rock hit by Megadeth",
                "Nobody knows"]),
        Question(
            questionText: "Who founded the X-Men?",
            correctAnswer: 1,
            userAnswer: nil,
            answers: [
                "Tony Stark",
                "Professor X",
                "The X-Institute",
                "Erik Lensherr"]),
        Question(
            questionText: "How did Spider-Man get his powers?",
            correctAnswer: 0,
            userAnswer: nil,
            answers: [
                "He was bitten by a radioactive spider",
                "He ate a radioactive spider",
                "He is a radioactive spider",
                "He looked at a radioactive spider"])
    ]
    
    let scienceQuestions = [
        Question(
            questionText: "What is fire?",
            correctAnswer: 0,
            userAnswer: nil,
            answers: [
                "One of the four classical elements",
                "A magical reaction given to us by God",
                "A band that hasn't yet been discovered",
                "Fire! Fire! Fire! heh-heh"])
    ]
    
    var topics: [Topic]
    
    var topicNumber: Int
    var questionNumber: Int
    static let sharedInstance = TopicController()
    
    private override init(){
        self.topicNumber = 0
        self.questionNumber = 0
        
        self.topics = [
            Topic(title: "Mathmatics",
                  descr: "Mathematics is the study of topics such as quantity, structure, space, and change. There is a range of views among mathematicians and philosophers as to the exact scope and definition of mathematics.",
                  iconName: "math",
                  questions: mathQuestions),
            Topic(title: "Marvel",
                  descr: "Marvel Comics is the common name and primary imprint of Marvel Worldwide Inc., formerly Marvel Publishing, Inc. and Marvel Comics Group, an American publisher of comic books and related media.",
                  iconName: "hero",
                  questions: marvelQuestions),
            Topic(title: "Science",
                  descr: "Science is a systematic enterprise that builds and organizes knowledge in the form of testable explanations and predictions about the universe.",
                  iconName: "science",
                  questions: scienceQuestions)]
        
        super.init()
    }
    
    func isLastQuestion() -> Bool{
        return true
    }
    
    func reset(){
        
    }
    
}
