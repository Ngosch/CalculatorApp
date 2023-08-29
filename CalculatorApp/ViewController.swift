////
//  ViewController.swift
//  CalculatorApp
//
//  Created by Ngos on 2023/08/27.
//

import UIKit

class ViewController: UIViewController {
    var firstNumStr = ""
    var secondNumStr = ""
    var operatorStr = ""
    var resultNumStr = ""
    var enteredFirstNumFlag: Bool = false
    var afterCaliuculationFlag = false

    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textLabel.text = ""
    }
    
    @IBAction func pressNum(_ sender: UIButton) {
        var pushed_num = (sender.titleLabel?.text)!
        print(pushed_num + "が入力されました。")
        if enteredFirstNumFlag == false {
            firstNumStr += pushed_num
            textLabel.text = firstNumStr
        } else if enteredFirstNumFlag && afterCaliuculationFlag == false {
            secondNumStr += pushed_num
            textLabel.text = secondNumStr
        }
    }
    
    @IBAction func pressOperator(_ sender: UIButton){
        var pushed_arithmetic = (sender.titleLabel?.text)!
        print(pushed_arithmetic + "が入力されました。")
        if enteredFirstNumFlag == false && firstNumStr != "" {
            operatorStr = (sender.titleLabel?.text)!
            enteredFirstNumFlag = true
        }
    }
    
    @IBAction func pressEqual(_ sender: UIButton) {
        if firstNumStr != "" && secondNumStr != "" && operatorStr != "" {
            if let firstNumDouble = Double(firstNumStr), let secondNumDouble = Double(secondNumStr) {
                switch operatorStr {
                case "+":
                    let resultNum = firstNumDouble + secondNumDouble
                    resultNumStr = String(resultNum)
                    textLabel.text = resultNumStr
                case "-":
                    let resultNum = firstNumDouble - secondNumDouble
                    resultNumStr = String(resultNum)
                    textLabel.text = resultNumStr
                case "*":
                    let resultNum = firstNumDouble * secondNumDouble
                    resultNumStr = String(resultNum)
                    textLabel.text = resultNumStr
                case "/":
                    if secondNumDouble != 0 {
                        let resultNum = firstNumDouble / secondNumDouble
                        resultNumStr = String(resultNum)
                        textLabel.text = resultNumStr
                    } else {
                        textLabel.text = "エラー！"
                        print("0で割ったため")
                    }
                default: break
                }
                afterCaliuculationFlag = true
                print(resultNumStr + "が出力されました。")
            }
        }
    }
    
    @IBAction func allClear(_ sender: UIButton) {
        firstNumStr = ""
        secondNumStr = ""
        operatorStr = ""
        textLabel.text = ""
        enteredFirstNumFlag = false
        afterCaliuculationFlag = false
        print("All Clearが実行されました。")
    }
}
