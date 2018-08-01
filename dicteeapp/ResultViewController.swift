//
//  ResultViewController.swift
//  dicteeapp
//
//  Created by Yu Sun on 7/31/18.
//  Copyright © 2018 Andrew Tang. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    var totalCorrect: Int!
    var totalIncorrect: Int!
    @IBOutlet weak var correctTextView: UILabel!
    @IBOutlet weak var incorrectTextView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        correctTextView.text = "Total Correct: " + String(self.totalCorrect!)
        incorrectTextView.text = "Total Incorrect:" + String(self.totalIncorrect!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
