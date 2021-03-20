//
//  ViewController.swift
//  tp1 groupe 3
//
//  Created by Andy Randrianirina on 19/03/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelResult: UILabel!
    var currentMemory:Array<String>! = Array<String>()
    
    //First line
    @IBAction func onClick(_ sender: UIButton) {
        let current = sender.currentTitle?.lowercased() ?? ""
        if(isOperator(value: current) && currentMemory.count == 0){
            return
        }
        if(isOperator(value:current) && isOperator(value:currentMemory.last)){
            currentMemory[currentMemory.count - 1] = current
        }
        else{
            currentMemory.append(current)
        }
        labelResult.text = currentMemory.joined()
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
    
    func isOperator(value: String?) -> Bool {
        return value == "+" || value == "-" || value == "x" || value == "/"
    }

    func calculate(operation: [String]) -> Double {
        var result: Double = Double(operation[0])!
        var operateur: String = ""
        for n in operation {
            if isOperator(value: n) {
                operateur = n
                continue
            }
            let value = Double(n)!
            switch(operateur) {
                case "+":
                    result += value
                case "-":
                    result -= value
                case "x":
                    result *= value
                case "/":
                    result /= value
                    break
                default:
                    break
            }
        }
        return result
    }

    func calculate2(operation: [String]) -> Double {
        var tmp = operation // make mutable
        print(operation.joined(separator: " "))
        multiplication(operation: &tmp)
        division(operation: &tmp)
        return calculate(operation: tmp)
    }


    func multiplication(operation: inout [String]) {
        if let index = operation.index(of: "x") {
            let a = Double(operation[index-1])!
            let b = Double(operation[index+1])!
            operation[index] = String(a * b)
            operation.remove(at: index+1)
            operation.remove(at: index-1)
            multiplication(operation: &operation)
        }
    }

    func division(operation: inout [String]) {
        if let index = operation.index(of: "/") {
            let a = Double(operation[index-1])!
            let b = Double(operation[index+1])!
            operation[index] = String(a / b)
            operation.remove(at: index+1)
            operation.remove(at: index-1)
            division(operation: &operation)
        }
    }

    func getPriority(operation: [String], priority: [String]) -> [String]{
        var tmp: [String] = [operation[0]]
        for n in 1 ..< operation.count {
            if isOperator(value: operation[n])  {
                tmp.append(operation[n])
            }
        }
        return tmp
    }

    func remove(operation: inout [String]) {
        operation.removeLast();
    }
}

