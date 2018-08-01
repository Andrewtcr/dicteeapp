//
//  TestSelectionViewController.swift
//  dicteeapp
//
//  Created by Yu Sun on 7/30/18.
//  Copyright © 2018 Andrew Tang. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TestSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let text = data[indexPath.row]
        cell.textLabel?.text = text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("here")
        print(self.data[indexPath.row])
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "showTest", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTest" {
            // Setup new view controller
            let vc = segue.destination as? ViewController
            vc?.title = self.data[selectedIndex]
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var ref: DatabaseReference!
    var data: [String] = []
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ref = Database.database().reference()
        ref.child("myfirstios").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            for s in snapshot.children.allObjects as! [DataSnapshot] {
                print (s.key)
                self.data.append(s.key)
            }
            self.tableView.dataSource = self
            self.tableView.delegate = self
        }) { (error) in
            print(error.localizedDescription)
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
