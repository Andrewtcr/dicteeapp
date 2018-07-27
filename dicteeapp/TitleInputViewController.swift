//
//  TitleInputViewController.swift
//  dicteeapp
//
//  Created by Yu Sun on 7/26/18.
//  Copyright © 2018 Andrew Tang. All rights reserved.
//

import UIKit

class TitleInputViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let vc = segue.destination as? RecordUIViewControl
        vc?.title = titleTextField.text
        print ("passed")
    }
    

}
