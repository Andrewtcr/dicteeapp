//
//  SplashScreenViewController.swift
//  dicteeapp
//
//  Created by Yu Sun on 7/23/18.
//  Copyright © 2018 Andrew Tang. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        perform(#selector(showHome), with: nil, afterDelay: 3)
    }
    
    @objc func showHome() {
        performSegue(withIdentifier: "showHome", sender: self)
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
