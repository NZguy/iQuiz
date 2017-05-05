//
//  TopicController.swift
//  iQuiz
//
//  Created by Duncan Andrew on 5/3/17.
//  Copyright © 2017 Duncan Andrew. All rights reserved.
//

import UIKit

class TopicController: NSObject {
    
    let mathQuestions = [
        Question(
            questionText: "What is 2+2?",
            correctAnswer: 0,
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
            answers: [
                "Tony Stark",
                "Obadiah Stane",
                "A rock hit by Megadeth",
                "Nobody knows"]),
        Question(
            questionText: "Who founded the X-Men?",
            correctAnswer: 1,
            answers: [
                "Tony Stark",
                "Professor X",
                "The X-Institute",
                "Erik Lensherr"]),
        Question(
            questionText: "How did Spider-Man get his powers?",
            correctAnswer: 0,
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
            answers: [
                "One of the four classical elements",
                "A magical reaction given to us by God",
                "A band that hasn't yet been discovered",
                "Fire! Fire! Fire! heh-heh"])
    ]
    
    var topics: [Topic]
    
    // TODO: Use correct getters and setters
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
    
    func setTopicNum(_ number: Int){
        self.topicNumber = number
    }
    
    func getTopicNum() -> Int{
        return self.topicNumber
    }
    
    func setQuestionNum(_ number: Int){
        self.questionNumber = number
    }
    
    func getQuestionNum() -> Int{
        return self.questionNumber
    }
    
    func isLastQuestion() -> Bool{
        return self.questionNumber >= (self.topics[self.topicNumber].questions.count - 1)
    }
    
    func reset(){
        self.setQuestionNum(0)
        self.setTopicNum(0)
    }
    
    func getCurrentQuestion() -> Question{
        return self.topics[self.topicNumber].questions[self.questionNumber]
    }
    
    func getCurrentTopic() -> Topic{
        return self.topics[self.topicNumber]
    }
    
    // TODO: How could I make this a function of question
    // Need to pass a pointer?
    func setCurrentQuestionUserAnswer(_ answer: Int){
        self.topics[self.topicNumber].questions[self.questionNumber].userAnswer = answer
    }
    
}

class Topic: NSObject{
    var title : String
    var descr : String
    var iconName : String
    var questions : [Question]
    
    init(title: String, descr: String, iconName: String, questions: [Question]){
        self.title = title
        self.descr = descr
        self.iconName = iconName
        self.questions = questions
        
        super.init()
    }
    
    func getNumberCorrect() -> Int{
        var numberCorrect = 0
        
        for question in self.questions{
            if question.userAnswer != nil{
                if question.userAnswer == question.correctAnswer{
                    numberCorrect += 1
                }
            }
        }
        
        return numberCorrect
    }
}

class Question: NSObject {
    
    var questionText : String
    var correctAnswer : Int
    var userAnswer : Int?
    var answers : [String]
    
    init(questionText: String, correctAnswer: Int, answers: [String]) {
        self.questionText = questionText
        self.correctAnswer = correctAnswer
        self.answers = answers
        self.userAnswer = nil
        
        super.init()
    }
    
    // Does nothing yet
    func setUserAnswer(){
        
    }
}

