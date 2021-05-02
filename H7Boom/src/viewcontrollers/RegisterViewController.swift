//
//  RegisterViewController.swift
//  H7Boom
//
//  Created by שחר זנגי on 01/05/2021.
//  Copyright © 2021 שחר זנגי. All rights reserved.
//

import Foundation
import UIKit

class RegisterViewController : UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nicknameWarning: UILabel!
    @IBOutlet weak var passwordWarning: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set textfield's delegate
        nicknameTextField.delegate = self
        passwordTextField.delegate = self
    }
    private func checkTextFields()->Bool{
        guard let nickname = nicknameTextField.text else { return false }
        guard let password = passwordTextField.text else { return false }
        
        if nickname.isEmpty || password.isEmpty{
            // show warnings
            nicknameWarning.alpha = CGFloat(nickname.isEmpty ? 1 : 0)
            passwordWarning.alpha = CGFloat(password.isEmpty ? 1 : 0)
            return false
        }
        else {return true}
    }
    @IBAction func signupClicked(_ sender: Any) {
        if checkTextFields(){
            var userExists = DatabaseHandler.userExists(nicknameTextField.text!)
            if (userExists != nil){
                if (userExists!)
                {
                // user already exists
                nicknameWarning.alpha = CGFloat(1) // turn on warning
                let alert = UIAlertController(title: "User exists.", message: "A user already exist with this nickname.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Okay.", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: false, completion: nil)
                }
                else{
                    DatabaseHandler.createUser(nickname: nicknameTextField.text!, password: passwordTextField.text!)
                    Helper.tryLogin(nickname: nicknameTextField.text!, password: passwordTextField.text!)
                    self.dismiss(animated: true, completion: {self.presentingViewController?.dismiss(animated: false, completion: nil)})
                }
            } else{
                let alert = UIAlertController(title: "Server not responding", message: "too much time for response.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Okay.", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: false, completion: nil)
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == self.nicknameTextField{
            self.passwordTextField.becomeFirstResponder()
            
        } else{
            self.view.endEditing(true)
        }
        return true
    }
}
