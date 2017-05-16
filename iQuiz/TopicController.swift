//
//  TopicController.swift
//  iQuiz
//
//  Created by Duncan Andrew on 5/3/17.
//  Copyright © 2017 Duncan Andrew. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class TopicController{
    
    enum MyError : Error {
        case RuntimeError(String)
    }
    
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
    
    let nc = NotificationCenter.default
    
    var topics: [Topic]
    var dataURL: String
    
    // TODO: Use correct getters and setters
    var topicNumber: Int
    var questionNumber: Int
    static let sharedInstance = TopicController()
    
    private init(){
        self.topicNumber = 0
        self.questionNumber = 0
        
        
        
//        self.topics = [
//            Topic(title: "Mathmatics",
//                  descr: "Mathematics is the study of topics such as quantity, structure, space, and change. There is a range of views among mathematicians and philosophers as to the exact scope and definition of mathematics.",
//                  iconName: "math",
//                  questions: mathQuestions),
//            Topic(title: "Marvel",
//                  descr: "Marvel Comics is the common name and primary imprint of Marvel Worldwide Inc., formerly Marvel Publishing, Inc. and Marvel Comics Group, an American publisher of comic books and related media.",
//                  iconName: "hero",
//                  questions: marvelQuestions),
//            Topic(title: "Science",
//                  descr: "Science is a systematic enterprise that builds and organizes knowledge in the form of testable explanations and predictions about the universe.",
//                  iconName: "science",
//                  questions: scienceQuestions)]
        
        self.topics = []
        
        // Try to get data from store with a default fallback
        let dataURL = UserDefaults.standard.value(forKey: "dataURL")
        if dataURL != nil{
            self.dataURL = dataURL as! String
        }else{
            self.dataURL = "http://tednewardsandbox.site44.com/questions.json"
        }
        
        // Try to get data from store
        if let topicJSON = UserDefaults.standard.value(forKey: "topicJSON") as? String{
            self.jsonToTopics(json: topicJSON)
        }
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
        return self.questionNumber >= (self.topics[self.topicNumber].questions!.count - 1)
    }
    
    func reset(){
        self.setQuestionNum(0)
        self.setTopicNum(0)
    }
    
    func getCurrentQuestion() -> Question{
        return self.topics[self.topicNumber].questions![self.questionNumber]
    }
    
    func getCurrentTopic() -> Topic{
        return self.topics[self.topicNumber]
    }
    
    func loadDataFromWeb() {
        
        Alamofire.request(self.dataURL).responseJSON { response in
            
            switch response.result {
            case .success:
                // Question: How could I shorten this to an if statement
                print("success")
            case .failure:
                // Question: How could I return an error from this async function 
                // http://stackoverflow.com/questions/33927530/using-a-value-from-alamofire-request-outside-the-function
                print("error")
                self.nc.post(name: NSNotification.Name(rawValue: "downloadError"), object: nil)
            }
                
            if let JSON = response.result.value {
                // Parse JSON
                print("parsing json")
                self.jsonToTopics(json: JSON)
            }else{
                print("not parsing: ")
            }
        }
        
    }
    
    func jsonToTopics(json: Any?){
        // Parse json into topic objects and set self.topics
        let topics = Mapper<Topic>().mapArray(JSONObject: json)
        
        for topic in topics!{
            let title = topic.title
            var iconName = "math" // replace with default in the future
            switch title!{
            case "Science!":
                iconName = "science"
            case "Marvel Super Heroes":
                iconName = "hero"
            case "Mathematics":
                iconName = "math"
            default:
                print("why do I need a default with a statement in it")
            }
            topic.iconName = iconName
            
        }
        
        self.topics = topics!
        
        print(topics![1].questions![0])
        
        nc.post(name: NSNotification.Name(rawValue: "topicsRefreshed"), object: nil)
    }
    
}

class Topic: Mappable{
    var title : String?
    var descr : String?
    var iconName : String?
    var questions : [Question]?
    
    init(title: String, descr: String, iconName: String, questions: [Question]){
        self.title = title
        self.descr = descr
        self.iconName = iconName
        self.questions = questions
    }
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map){
        title <- map["title"]
        descr <- map["desc"]
        questions <- map["questions"]
    }
    
    func getNumberCorrect() -> Int{
        var numberCorrect = 0
        
        for question in self.questions!{
            if question.userAnswer != nil{
                if question.userAnswer == question.correctAnswer{
                    numberCorrect += 1
                }
            }
        }
        
        return numberCorrect
    }
}

class Question: Mappable {
    
    var questionText : String?
    var correctAnswer : Int?
    var userAnswer : Int?
    var answers : [String]?
    
    init(questionText: String, correctAnswer: Int, answers: [String]) {
        self.questionText = questionText
        self.correctAnswer = correctAnswer
        self.answers = answers
        self.userAnswer = nil
    }
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map){
        questionText <- map["text"]
        correctAnswer <- map["answer"]
        answers <- map["answers"]
    }
    
    // Does nothing yet
    func setUserAnswer(_ userAnswer: Int){
        self.userAnswer = userAnswer
    }
}

