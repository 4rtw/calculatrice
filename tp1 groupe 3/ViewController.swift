//
//  ViewController.swift
//  tp1 groupe 3
//
//  Created by Andy Randrianirina on 19/03/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelResult: UILabel!
    
    
    //First line
    @IBAction func onClick(_ sender: UIButton) {
        switch sender.currentTitle{
            
        }
    }
    
    @IBOutlet weak var b7: UIButton!
    @IBOutlet weak var b8: UIButton!
    @IBOutlet weak var b9: UIButton!
    @IBOutlet weak var bDiv: UIButton!
    
    //Second line
    @IBOutlet weak var b4: UIButton!
    @IBOutlet weak var b5: UIButton!
    @IBOutlet weak var b6: UIButton!
    @IBOutlet weak var bMinus: UIButton!
    
    //Third line
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var bTimes: UIButton!
    
    //Fourth line
    @IBOutlet weak var b0: UIButton!
    @IBOutlet weak var bEqual: UIButton!
    @IBOutlet weak var bClear: UIButton!
    @IBOutlet weak var bAdd: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

