//
//  ViewController.swift
//  Calculator
//
//  Created by Papa Ray on 9/22/17.
//  Copyright © 2017 RTG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userInTyping: Bool = false
    
    var tempValue = 0.0
    var tempOperator = ""
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            var strValue = String(newValue)
            let pointIndex = strValue.index(of: ".")!
            if strValue.substring(from: pointIndex) == ".0" {
                strValue = strValue.substring(to: pointIndex)
            }
            display.text = strValue
        }
    }

    //按下数字键
    @IBAction func touchDigit(_ sender: UIButton) {
        var strDigit = sender.currentTitle!
        
        if userInTyping {
            let textCurrentlyInDisplay = display.text!
            if textCurrentlyInDisplay.contains(".") && strDigit == "." {
                return
            }
            display.text = textCurrentlyInDisplay + strDigit
        } else {
            if strDigit == "." {
                strDigit = "0" + strDigit
            }
            display.text = strDigit
            userInTyping = true;
        }
    }
    
    private var brain: CalculatorBrain = CalculatorBrain()
    
    //按下运算符
    @IBAction func performOperation(_ sender: UIButton) {
        if userInTyping {
            brain.setOperand(displayValue)
            userInTyping = false
        }
        if let mathSymbol = sender.currentTitle {
            brain.performOperation(mathSymbol)
        }
        if let result = brain.result {
            displayValue = result
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

