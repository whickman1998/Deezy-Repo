//
//  SignUpViewController.swift
//  Deezy
//
//  Created by William Hickman on 11/16/19.
//  Copyright © 2019 William Hickman Ent. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController, UITextFieldDelegate {

    var username = ""
    var password = ""
    
    @IBOutlet var uField: UITextField!
    @IBOutlet var pField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        NSLog("restorationIdentifier: \(textField.restorationIdentifier!)")
        if textField.restorationIdentifier == "UTF" {
            username = textField.text!
        }
        else if textField.restorationIdentifier == "PTF" {
            password = textField.text!
        }
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func signUp(_ sender: Any) {
        if validateCredentials() {
            Auth.auth().createUser(withEmail: username, password: password, completion: { authResult, error in
                if error != nil {
                    self.uField.text = ""
                    self.pField.text = ""
                }
                else {
                    NSLog("\(authResult!)")
                    Auth.auth().signIn(withEmail: self.username, password: self.password, completion: { [weak self] user, error in
                        guard let strongSelf = self else { return }
                        guard let user = user else {
                            NSLog("Yikes")
                        }
                        Profile.user.uid = user.user.uid
                        DatabaseManager.uploadUser(uid: user.user.uid)
                        strongSelf.performSegue(withIdentifier: "signupsucc", sender: nil)
                    })
                }
            })
        }
        else {
            NSLog("error")
        }
    }
    
    private func validateCredentials() -> Bool {
        //Basic verifier, can check email later
        NSLog("U: \"\(username)\", P: \"\(password)\"")
        return username != "" && password != ""
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
