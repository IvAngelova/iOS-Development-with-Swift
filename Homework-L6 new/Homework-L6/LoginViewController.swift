//
//  ViewController.swift
//  Homework-L6
//
//  Created by Ivy Angelova (Apprentice Mobile, eDynamix Training Programme) on 06/01/2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        
        // Do any additional setup after loading the view.
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.usernameTextField:
            self.passwordTextField.becomeFirstResponder()
        case self.passwordTextField:
            self.passwordTextField.resignFirstResponder()
        default:
            break
        }
        
        return true
    }
}
