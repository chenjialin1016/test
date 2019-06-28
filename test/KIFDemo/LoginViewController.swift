//
//  LoginViewController.swift
//  test
//
//  Created by Jialin Chen on 2019/6/17.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func isValideLogin(name: String, password: String) -> Bool {
        if name.isEmpty || password.isEmpty {
            return false
        }
        
        return true
    }
    
    @IBAction func loginAction(_ sender: Any) {
        guard isValideLogin(name: nameTextField.text!, password: pwdTextField.text!) else {
            return
        }
        
        let story = UIStoryboard(name: "Main", bundle: nil)
        let tabController = story.instantiateViewController(withIdentifier: "TabControllerID")
        UIApplication.shared.keyWindow?.rootViewController = tabController
    }
}
