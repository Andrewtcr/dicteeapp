//
//  ViewController.swift
//  demoone
//
//  Created by Yu Sun on 6/28/18.
//  Copyright © 2018 Yu Sun. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionTitle: UILabel!
    
    var counter : Int = 0
    var questionIndex : Int = -1
    var questions : [Question] = []
    var player = AVPlayer()

    let letters = CharacterSet.letters
    let digits = CharacterSet.decimalDigits

    
    @IBOutlet weak var questionAnswerTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let q1 = Question()
        q1.title = "Test 1"
        q1.audioURL = "https://firebasestorage.googleapis.com/v0/b/realreviews-a5de6.appspot.com/o/tests-audio%2Frecording.m4a?alt=media&token=fb6e1321-2bb1-4790-9ac4-55e202c66de0"
        q1.points = 10
        q1.answer = "I am always very busy in the morning"
        
        let q2 = Question(t:"Test 2", url:"https://s3-us-west-1.amazonaws.com/frenchapp/test1.mp3", a:"I am more confident now", p:5)
        questions = [q1, q2]
        
        nextQuestion()
    }

    func nextQuestion() {
        if (questionIndex < questions.count) {
            questionIndex += 1
            questionTitle.text = questions[questionIndex].title
            questionAnswerTextView.text = questions[questionIndex].answer
        }
    }
    
    @IBAction func onSubmitClicked(_ sender: Any) {
        var yourAnswer = extractLetters(str:(answerField.text?.lowercased())!)
        var correctAnswer = extractLetters(str:questions[questionIndex].answer.lowercased())
        
        print(yourAnswer)
        print(correctAnswer)
        
        if (compareAnswers(a1: yourAnswer, a2:correctAnswer)) {
            answerLabel.text = "Correct!"
        } else {
            answerLabel.text = "Incorrect!"
        }
        
    }
    
    @IBAction func onNextClicked(_ sender: UIButton) {
        nextQuestion()
        answerLabel.text = ""
        answerField.text = ""
    }
    
    func extractLetters(str : String) -> String {
        var res:String = ""
        for c in str.unicodeScalars {
            if (letters.contains(c)) {
                res += String(c)
            }
        }
        return res
    }
    
    func compareAnswers(a1:String, a2:String) -> Bool {
        if (a1 == a2) {
            return true
        } else {
            return false
        }
    }
    
    @IBAction func onStopButtonClicked(_ sender: UIButton) {
        player.pause()
    }
    
    @IBOutlet weak var answerField: UITextField!
    
    @IBAction func onPlayClicked(_ sender: UIButton) {
        let playerItem = AVPlayerItem(url: URL(string: questions[questionIndex].audioURL)!)
        player = AVPlayer(playerItem: playerItem)
        player.play()
    }
}

