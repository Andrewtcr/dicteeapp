//
//  PassCodeViewController.swift
//  dicteeapp
//
//  Created by Yu Sun on 8/1/18.
//  Copyright © 2018 Andrew Tang. All rights reserved.
//

import UIKit

class PassCodeViewController: UIViewController {

    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet var invalidTextField: UIView!
    
    @IBOutlet weak var megTextView: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onCreateClicked(_ sender: UIButton) {
        if (passTextField.text != "1234") {
            megTextView.text = "Invalid teacher passcode!"
        } else {
            performSegue(withIdentifier: "startCreate", sender: self)
        }
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
