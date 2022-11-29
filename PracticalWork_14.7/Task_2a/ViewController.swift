//
//  ViewController.swift
//  PracticalWork_14.7
//
//  Created by Alexandr on 23.11.2022.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var secondNameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTextField.text = Persistance.shared.userName
        secondNameTextField.text = Persistance.shared.userSecondName
        
    }
    
    @IBAction func actionFirst(_ sender: UITextField) {
        Persistance.shared.userName = firstNameTextField.text
    }
    @IBAction func actionSecond(_ sender: UITextField) {
        Persistance.shared.userSecondName = secondNameTextField.text
    }
    
}

