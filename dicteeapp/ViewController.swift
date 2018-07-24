//
//  ViewController.swift
//  dicteeapp
//
//  Created by Andrew Tang on 2018-07-22.
//  Copyright © 2018 Andrew Tang. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var userAnswerTextField: UITextField!
    
    var question: Question!
    var player = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        question = Question()
        question.title = "French 101"
        question.audioURL = "https://s3-us-west-1.amazonaws.com/frenchapp/test1.mp3"
        question.answer = "good morning everyone"
        question.points = 2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onSubmitClicked(_ sender: UIButton) {
       print (userAnswerTextField.text)
    }
    
    @IBAction func onPlayClicked(_ sender: UIButton) {
        let playerItem = AVPlayerItem(url: URL(string: question.audioURL)!)
        player = AVPlayer(playerItem: playerItem)
        player.play()
    }
    
    @IBAction func onStopClicked(_ sender: UIButton) {
        player.pause()
    }

}

