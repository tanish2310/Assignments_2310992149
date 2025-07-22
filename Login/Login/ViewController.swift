//
//  ViewController.swift
//  Login
//
//  Created by Tanish on 21/07/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var UsernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.navigationItem.title = UsernameTextField.text
    }
}
