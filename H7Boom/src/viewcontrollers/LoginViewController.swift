//
//  LoginViewController.swift
//  H7Boom
//
//  Created by שחר זנגי on 01/05/2021.
//  Copyright © 2021 שחר זנגי. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController : UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nicknameWarning: UILabel!
    @IBOutlet weak var passwordWarning: UILabel!
    
    @IBAction func loginClicked(_ sender: Any) {
        guard let nickname = nicknameTextField.text else { return }
        guard let password = passwordTextField.text else {  return}
        
        if nickname.isEmpty || password.isEmpty{
            // turn on warnings accourdingly
            nicknameWarning.alpha = CGFloat(nickname.isEmpty ? 1 : 0);
            passwordWarning.alpha = CGFloat(password.isEmpty ? 1 : 0);
        }
        else{
            // nickname and password fields are not empty
            var didLogin = Helper.tryLogin(nickname: nickname, password: password)
            if (didLogin == nil) {
                let alert = UIAlertController(title: "Server not responding", message: "No response from server", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Okay.", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: false, completion: nil)
                return
            }
            else if (didLogin!){
                // login successful
                print("logged in.")
                self.dismiss(animated: true, completion: nil)
            } else{
                // show login error alert
                let alert = UIAlertController(title: "Login information is wrong.", message: "If you are not registered, click the register button!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Okay.", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: false, completion: nil)
                
            }
        }

        
    }
    @IBAction func registerClicked(_ sender: Any) {
        performSegue(withIdentifier: "registerSegue", sender: self)
    }
    override func viewDidLoad(){
        super.viewDidLoad()
        
        // hide warnings
        nicknameWarning.alpha = CGFloat(0)
        passwordWarning.alpha = CGFloat(0)
        
        // set textfield's delegate
        nicknameTextField.delegate = self
        passwordTextField.delegate = self
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
