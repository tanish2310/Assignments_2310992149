//
//  MiddleViewController.swift
//  OrderOfEvents
//
//  Created by Tanish on 01/08/25.
//

import UIKit

class MiddleViewController: UIViewController {
    
    
    @IBOutlet weak var MiddleViewLabel: UILabel!
    
    var eventNumber: Int = 1
    
    func addEvent (from: String) {
        if let existingText = MiddleViewLabel.text {
            MiddleViewLabel.text = "\(existingText)\nEvent number\(eventNumber) was \(from) "
            eventNumber += 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addEvent(from: "viewDidLoad")

        // Do any additional setup after loading the view.
    }
     func viewWillApear() {
        super.viewDidLoad()
        addEvent(from: "viewDidLoad")

        // Do any additional setup after loading the view.
    }
     func viewDidAppear() {
        super.viewDidLoad()
        addEvent(from: "viewDidLoad")

        // Do any additional setup after loading the view.
    }
     func viewWillDisapear() {
        super.viewDidLoad()
        addEvent(from: "viewDidLoad")

        // Do any additional setup after loading the view.
    }
     func viewDidDidappear() {
        super.viewDidLoad()
        addEvent(from: "viewDidLoad")

        // Do any additional setup after loading the view.
    }
    
    
    


}
