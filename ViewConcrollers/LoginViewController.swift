//
//  LoginViewController.swift
//  Deezy
//
//  Created by William Hickman on 11/16/19.
//  Copyright © 2019 William Hickman Ent. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var deezytext: UIImageView!
    private var username = ""
    private var password = ""
    
    @IBOutlet var uField: UITextField!
    @IBOutlet var pField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.restorationIdentifier == "UTF" {
            username = textField.text!
        }
        else if textField.restorationIdentifier == "PTF" {
            password = textField.text!
        }
        textField.resignFirstResponder()
        return true
    }

    @IBAction func loginPressed(_ sender: Any) {
        Auth.auth().signIn(withEmail: username, password: password, completion: { [weak self] user, error in
            guard let strongSelf = self else { return }
            if error != nil {
                strongSelf.uField.text = ""
                strongSelf.pField.text = ""
            }
            else {
                strongSelf.performSegue(withIdentifier: "login", sender: nil)
            }
        })
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    

}
