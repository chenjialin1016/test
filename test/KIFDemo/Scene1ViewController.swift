//
//  Scene1ViewController.swift
//  Demo
//
//  Created by Smiacter on 2017/12/5.
//  Copyright © 2017年 Jinyi. All rights reserved.
//

import UIKit

class Scene1ViewController: UIViewController {
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGes = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(tapGes)
        
        stepper.accessibilityLabel = "stepper"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func endEditing() {
        view.endEditing(true)
    }
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        countLabel.text = "\(Int(sender.value))"
    }
}
