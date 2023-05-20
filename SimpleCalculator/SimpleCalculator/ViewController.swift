//
//  ViewController.swift
//  SimpleCalculator
//
//  Created by Ivy Angelova (Apprentice Mobile, eDynamix Training Programme) on 29/12/2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    var userInput: String = ""
    var isExpressionCalculated: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearAll()
        // Do any additional setup after loading the view.
    }
    
    func clearAll() {
        userInput = ""
        inputLabel.text = ""
        resultLabel.text = ""
    }
    
    func addToInput(value: String) {
        userInput = userInput + value
        inputLabel.text = userInput
    }


    @IBAction func allClearTapped(_ sender: UIButton) {
        clearAll()
    }
    
    
    @IBAction func equalsTapped(_ sender: UIButton) {
        let expression = NSExpression(format: userInput).floatifiedForDivisionIfNeeded
        let result = expression.expressionValue(with: nil, context: nil) as! Double
        let resultString = formatResult(result: result)
        self.resultLabel.text = resultString
        self.isExpressionCalculated = true
    }
    
    
    func formatResult(result: Double) -> String {
        if (result.truncatingRemainder(dividingBy: 1) == 0) {
            return String(format: "%.0f", result)
        } else {
            return String(format: "%.2f", result)
        }
    }
    
    
    @IBAction func minusTapped(_ sender: UIButton) {
        if isExpressionCalculated {
            clearAll()
        }
        addToInput(value: "-")
    }
    
    
    @IBAction func divideTapped(_ sender: UIButton) {
        if isExpressionCalculated {
            clearAll()
        }
        addToInput(value: "/")
    }
    
    @IBAction func plusTapped(_ sender: UIButton) {
        if isExpressionCalculated {
            clearAll()
        }
        addToInput(value: "+")
    }
    
    @IBAction func multiplyTapped(_ sender: UIButton) {
        if isExpressionCalculated {
            clearAll()
        }
        addToInput(value: "*")
    }
    
    
    @IBAction func oneTapped(_ sender: UIButton) {
        if isExpressionCalculated {
            clearAll()
        }
        addToInput(value: "1")
        self.isExpressionCalculated = false
    }
    
    
    @IBAction func twoTapped(_ sender: UIButton) {
        if isExpressionCalculated {
            clearAll()
        }
        addToInput(value: "2")
        self.isExpressionCalculated = false
    }
    
    
    @IBAction func threeTapped(_ sender: UIButton) {
        if isExpressionCalculated {
            clearAll()
        }
        addToInput(value: "3")
        self.isExpressionCalculated = false
    }
    
    
    @IBAction func fourTapped(_ sender: UIButton) {
        if isExpressionCalculated {
            clearAll()
        }
        addToInput(value: "4")
        self.isExpressionCalculated = false
    }
    
    
    @IBAction func fiveTapped(_ sender: UIButton) {
        if isExpressionCalculated {
            clearAll()
        }
        addToInput(value: "5")
        self.isExpressionCalculated = false
    }
    
    
    @IBAction func sixTapped(_ sender: UIButton) {
        if isExpressionCalculated {
            clearAll()
        }
        addToInput(value: "6")
        self.isExpressionCalculated = false
    }
    
    @IBAction func sevenTapped(_ sender: UIButton) {
        if isExpressionCalculated {
            clearAll()
        }
        addToInput(value: "7")
        self.isExpressionCalculated = false
    }
    
    
    @IBAction func eightTapped(_ sender: UIButton) {
        if isExpressionCalculated {
            clearAll()
        }
        addToInput(value: "8")
        self.isExpressionCalculated = false
    }
    
    
    @IBAction func nineTapped(_ sender: UIButton) {
        if isExpressionCalculated {
            clearAll()
        }
        addToInput(value: "9")
        self.isExpressionCalculated = false
    }
    
    
    @IBAction func zeroTapped(_ sender: UIButton) {
        if isExpressionCalculated {
            clearAll()
        }
        addToInput(value: "0")
        self.isExpressionCalculated = false
    }
}

extension NSExpression {
    var floatifiedForDivisionIfNeeded: NSExpression {
        if function == "divide:by:", let args = arguments, let last = args.last,
          let firstValue = args.first?.constantValue as? NSNumber {
            let newFirst = NSExpression(forConstantValue: firstValue.doubleValue)
            return NSExpression(forFunction: function, arguments: [newFirst, last])
        } else {
            return self
        }
    }
}

