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
        
        self.topics = []
        
        // Try to get url data from store with a default fallback
        let dataURL = UserDefaults.standard.value(forKey: "dataURL")
        if dataURL != nil{
            print("got url from store")
            self.dataURL = dataURL as! String
        }else{
            self.dataURL = "http://tednewardsandbox.site44.com/questions.json"
        }
        
        // Try to get topic data from store
        if let topicJSON = UserDefaults.standard.value(forKey: "topicJSON") as? String{
            print("got topics from store")
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
        
        Alamofire.request(self.dataURL).responseString { response in
            
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
    
    func jsonToTopics(json: String){
        // Parse json into topic objects and set self.topics
        let topics = Mapper<Topic>().mapArray(JSONString: json)
        
        if topics != nil{
            // Save to userdefaults
            UserDefaults.standard.set(json, forKey: "topicJSON")

            
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
            
            nc.post(name: NSNotification.Name(rawValue: "topicsRefreshed"), object: nil)
        }else{
            self.nc.post(name: NSNotification.Name(rawValue: "downloadError"), object: nil)
        }
        
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
                if question.isCorrect(){
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
    
    // Transform from string to int required
    // http://stackoverflow.com/questions/35117916/using-alamofire-and-objectmapper-the-integer-value-always-zero
    func mapping(map: Map){
        questionText <- map["text"]
        correctAnswer <- (map["answer"], TransformOf<Int, String>(fromJSON: { Int($0!) }, toJSON: { $0.map { String($0) } }))
        answers <- map["answers"]
    }
    
    func isCorrect() -> Bool {
        // -1 needed to fix teds non zero based answer
        return self.userAnswer! == (self.correctAnswer! - 1)
    }
    
    // Does nothing yet
    func setUserAnswer(_ userAnswer: Int){
        self.userAnswer = userAnswer
    }
}

