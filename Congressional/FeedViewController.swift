//
//  FeedViewController.swift
//  Congressional
//
//  Created by Celine Yan on 4/9/17.
//  Copyright © 2017 Ayman Ahmed. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if user == nil {
                self.performSegue(withIdentifier: "feedGate", sender: self)
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
