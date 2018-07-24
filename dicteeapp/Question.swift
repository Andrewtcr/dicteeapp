//
//  Question.swift
//  dicteeapp
//
//  Created by Andrew Tang on 2018-07-22.
//  Copyright © 2018 Andrew Tang. All rights reserved.
//

import Foundation

class Question {
    
    var title : String = ""
    var audioURL : String = ""
    var answer : String = ""
    var points : Int = 0
    
    init() {
        title = ""
        audioURL = ""
        answer = ""
        points = 0
    }
    
    init(t:String, url:String, a:String, p:Int) {
        title = t
        audioURL = url
        answer = a
        points = p
    }
}
