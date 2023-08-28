//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Ngos on 2023/08/27.
//

import UIKit

class ViewController: UIViewController {
    // first number entered, second number entered, four arithmetic operators, variable for result of calculation
    var firstNumStr = ""
    var secondNumStr = ""
    var operatorStr = ""
    var resultNumStr = ""
    //fistNumが入力された後かどうかのフラグ。初期値false。
    //Bool値が入っているので型宣言は不要。
    //(今回は変数定義の際に直接falseを代入しているので型推論によって変数はBool型と判断されます。つまり型アノテーション(:Boolの部分)は無くても大丈夫です。)
    var enteredFirstNumFlag: Bool = false
    var afterCaliuculationFlag = false //After cal or not
    


    @IBOutlet weak var textLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //overwrite label name to void
        textLabel.text = ""
    }
    
    // conection to all button
    @IBAction func pressNum(_ sender: UIButton) {
        //display input number
        var pushed_num = (sender.titleLabel?.text)!
        print(pushed_num + "が入力されました。")
        if enteredFirstNumFlag == false{
            firstNumStr += pushed_num
            textLabel.text = firstNumStr
            
            
            //take out number from button title
            /*
             //below mandatory unlap take optional
             //string below
             print((sender.titleLabel?.text)!)
             */
            //input variable
            //firstNumStr += (sender.titleLabel?.text)!
            //same as firstNumStr = firstNumStr + (sender.titleLabel?.text!)!
            
            //insert number to firstNumStr
            //textLabel.text = firstNumStr
            
        } else if enteredFirstNumFlag && afterCaliuculationFlag == false
        //not yet complete cal & inputed first number
        {
            secondNumStr += pushed_num
            textLabel.text = secondNumStr
        }
    }
    
    //basic arithmetic operations
    @IBAction func pressOperator(_ sender: UIButton){
        var pushed_arithmetic = (sender.titleLabel?.text)!
        print(pushed_arithmetic + "が入力されました。")
        //not yet complete 1st number & something input 1st number
        // && means both
        if enteredFirstNumFlag == false && firstNumStr != "" {
            operatorStr = (sender.titleLabel?.text)!
            enteredFirstNumFlag = true
            // change to true flag
            }
        
    }
    
    //equal operation
    @IBAction func pressEqual(_ sender: UIButton) {
        //        print("firstNum: \(firstNumStr), secondNum: \(secondNumStr), operator: \(operatorStr)")
        
        //something input to all var
        if firstNumStr != ""
            && secondNumStr != ""
            && operatorStr != "" {
            //processing calculate
            //1つ目と2つ目の両方が型変換でint型にできるとき
            if let firstNumInt = Int(firstNumStr),
               let secondNumInt = Int(secondNumStr){
                
                //case change in operatorStr contents
                switch operatorStr {
                case "+":
                    let resultNum = firstNumInt + secondNumInt
                    resultNumStr = String(resultNum)//change model
                    textLabel.text = resultNumStr//display result
                case "-":
                    let resultNum = firstNumInt - secondNumInt
                    resultNumStr = String(resultNum)//change model
                    textLabel.text = resultNumStr//display result
                case "*":
                    let resultNum = firstNumInt * secondNumInt
                    resultNumStr = String(resultNum)//change model
                    textLabel.text = resultNumStr//display result
                case "/":
                    //
                    if secondNumInt != 0 {
                        let resultNum = firstNumInt / secondNumInt
                        resultNumStr = String(resultNum)//change model
                        textLabel.text = resultNumStr//display result
                    } else {
                        textLabel.text = "エラー！"
                        print("0で割ったため")
                    }
                default: break//Define other elements
                }
                afterCaliuculationFlag = true
                print(resultNumStr + "が出力されました。")
            }
        }
    }
    
    //when push AC button
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

