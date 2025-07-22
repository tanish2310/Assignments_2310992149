//
//  ViewController.swift
//  Login
//
//  Created by Tanish on 21/07/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var UsernameTextField: UITextField!
    
    
    @IBOutlet weak var ForgotUsername: UIButton!
    
    
    @IBOutlet weak var ForgotPassword: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.navigationItem.title = UsernameTextField.text
    }
    
    @IBAction func ForgotUsername(_ sender: UIButton) {
        performSegue(withIdentifier: "LoginPageToLanding", sender: sender)
    }
    
    
    @IBAction func ForgotPassword(_ sender: UIButton) {
        performSegue(withIdentifier: "LoginPageToLanding", sender: sender)
    }
}
