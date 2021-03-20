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
    var waitingForOperator:Bool! = false
    
    func reinit(){
        currentMemory = Array<String>()
        labelResult.text = "0"
    }
    
    //First line
    @IBAction func onClick(_ sender: UIButton) {
        //Clearing the input
        let current = sender.currentTitle?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        //Avoid taping multiple 0 at the beginning
        if((current) == "0" && ((current.count == 0) || (current.count == 1 && currentMemory.last == "0"))){
            return
        }
        
        //Avoid taping operator at the beginning
        if(isOperator(value: current) && currentMemory.count == 0){
            return
        }
        
        //Allow only operator after equals, otherwise reinit the calcul
        if(currentMemory.count == 1 && waitingForOperator){
            waitingForOperator = false
            if(!isOperator(value: current)){
                reinit()
            }
        }
        
        //Replace the operator by next operator
        if(isOperator(value:current) && isOperator(value:currentMemory.last)){
            currentMemory[currentMemory.count - 1] = current
        }
        
        //New element in memory if switching number/operator
        else if(isOperator(value: current) || currentMemory.count == 0 || isOperator(value:currentMemory.last)){
            currentMemory.append(current)
        }
        
        //Use the same element (concatenate) if number next number
        else{
            currentMemory[currentMemory.count - 1] += current
        }
        
        //Updating the view
        labelResult.text = currentMemory.joined()
    }
    
    @IBAction func onClickYellow(_ sender: UIButton) {
        let current = sender.currentTitle?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        //Cannot calculate if empty
        if(currentMemory.count == 0){
            return
        }
        //Clear the result
        if(current == "ce"){
            reinit()
        }
        //Calculate
        else if(current == "="){
            let result = calculate2(operation: currentMemory)
            var resultString = "\(result)"
            if  resultString.hasSuffix(".0"){
                resultString = resultString.replacingOccurrences(of: ".0", with: "")
            }
            reinit()
            currentMemory.append(resultString)
            labelResult.text = currentMemory.joined()
            waitingForOperator = true
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

