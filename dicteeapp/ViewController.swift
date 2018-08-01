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
import FirebaseDatabase

class ViewController: UIViewController {

    @IBOutlet weak var questionTitle: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    var counter : Int = 0
    var questionIndex : Int = -1
    var questions : [Question] = []
    var player = AVPlayer()
    var ref: DatabaseReference!
    var totalCorrect: Int = 0
    var totalIncorrect: Int = 0
    
    let letters = CharacterSet.letters
    let digits = CharacterSet.decimalDigits

    
    @IBOutlet weak var questionAnswerTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var qqq = Question(t:"Question ", url:"url", a:"answer", p:5)
        
        // Do any additional setup after loading the view, typically from a nib.
        ref = Database.database().reference()
        ref.child("myfirstios/" + self.title!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            var i = 1
            for s in snapshot.children.allObjects as! [DataSnapshot] {
                print (s.value)
                let dic = s.value as? NSDictionary
                print ("before ")
                print (dic)
                print ("after")
                var question = Question(t:"Question " + String(i), url:dic!["url"] as! String, a:dic!["answer"] as! String, p:5)
                print(question)
                self.questions.append(question)
                i += 1
            }
            self.nextQuestion()
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    func nextQuestion() {
        if (questionIndex < questions.count - 1) {
            questionIndex += 1
            questionTitle.text = questions[questionIndex].title
            //print (questions[questionIndex])
            //print (questions[questionIndex].answer)
            //questionAnswerTextView.text = questions[questionIndex].answer
        } else {
            performSegue(withIdentifier: "showResult", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResult" {
            // Setup new view controller
            let vc = segue.destination as? ResultViewController
            vc?.totalCorrect = self.totalCorrect
            vc?.totalIncorrect = self.totalIncorrect
            print(vc?.totalCorrect)
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showTest" {
//            // Setup new view controller
//            let vc = segue.destination as? ViewController
//            vc?.title = self.data[selectedIndex]
//        }
//    }
    
    @IBAction func onSubmitClicked(_ sender: Any) {
        var yourAnswer = extractLetters(str:(answerField.text?.lowercased())!)
        var correctAnswer = extractLetters(str:questions[questionIndex].answer.lowercased())
        
        print(yourAnswer)
        print(correctAnswer)
        
        if (compareAnswers(a1: yourAnswer, a2:correctAnswer)) {
            answerLabel.text = "Correct!"
            totalCorrect += 1
        } else {
            answerLabel.text = "Incorrect!"
            totalIncorrect += 1
        }
        
        //sleep(2)
        //nextQuestion()
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

