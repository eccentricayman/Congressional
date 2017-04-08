//
//  SignInViewController.swift
//  Congressional
//
//  Created by Celine Yan on 4/8/17.
//  Copyright © 2017 Ayman Ahmed. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet weak var userEmail: UITextField!
    
    @IBOutlet weak var userPassword: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    var isSignIn: Bool = true // Default is on Sign In
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signChanged(_ sender: Any) {
        isSignIn = !isSignIn
        
        if isSignIn{
            signInButton.setTitle("Login", for: .normal)
        }
        else{
            signInButton.setTitle("Register", for: .normal )
        }
    
    }
    
    
    @IBAction func buttonPressed(_ sender: Any) {
        if let email = userEmail.text, let pass = userPassword.text {
            if isSignIn{
                FIRAuth.auth()?.signIn(withEmail: email, password: pass, completion: { (user, error) in
                    
                    // Check that user isn't nil
                    if let u = user {
                        // User is found, go to home screen
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                    }
                    else {
                        // Error: check error and show message
                        println( "Error while signing in")
                    }
                    
                })
                
            }
            else {
                // Register the user with Firebase
                
                FIRAuth.auth()?.createUser(withEmail: email, password: pass, completion: { (user, error) in
                    
                    if let u = user {
                        //User is found
                        
                    }
                    else {
                        println("soemthign when wrong with register")
                    }
                })

        }
    
    
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
