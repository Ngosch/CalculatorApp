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
    var calculationHistory: [String] = []  // 計算履歴を保存する配列

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var historyLabel: UILabel!  // 計算履歴を表示するためのUILabel
    
    // グラデーションレイヤーをプロパティとして保持
    let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // グラデーションの初期設定
        gradientLayer.frame = self.view.bounds
        updateGradientColors()
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        textLabel.text = ""
        historyLabel.text = ""  // 計算履歴の初期化
    }
    
    // グラデーションの色をランダムに更新する関数
    func updateGradientColors() {
        let colors = [randomColor(), randomColor()]
        gradientLayer.colors = colors.map { $0.cgColor }
    }
    
    // ランダムな色を生成する関数
    func randomColor() -> UIColor {
        return UIColor(
            red: CGFloat(drand48()),
            green: CGFloat(drand48()),
            blue: CGFloat(drand48()),
            alpha: 1.0
        )
    }
    
    // 計算履歴を更新する関数
    func updateCalculationHistory(newEntry: String) {
        calculationHistory.append(newEntry)
        if calculationHistory.count > 5 {
            calculationHistory.removeFirst()
        }
        historyLabel.text = calculationHistory.joined(separator: "\n")
    }
    
    @IBAction func pressNum(_ sender: UIButton) {
        let pushedNum = sender.titleLabel?.text ?? ""
        print("\(pushedNum)が入力されました。")
        if enteredFirstNumFlag {
            secondNumStr += pushedNum
            textLabel.text = secondNumStr
        } else {
            firstNumStr += pushedNum
            textLabel.text = firstNumStr
        }
    }
    
    @IBAction func pressOperator(_ sender: UIButton) {
        let pushedOperator = sender.titleLabel?.text ?? ""
        print("\(pushedOperator)が入力されました。")
        if !enteredFirstNumFlag && !firstNumStr.isEmpty {
            operatorStr = pushedOperator
            enteredFirstNumFlag = true
        }
    }
    
    @IBAction func pressEqual(_ sender: UIButton) {
        if !firstNumStr.isEmpty && !secondNumStr.isEmpty && !operatorStr.isEmpty {
            if let firstNum = Double(firstNumStr), let secondNum = Double(secondNumStr) {
                var result: Double = 0
                switch operatorStr {
                case "+":
                    result = firstNum + secondNum
                case "-":
                    result = firstNum - secondNum
                case "*":
                    result = firstNum * secondNum
                case "/":
                    if secondNum != 0 {
                        result = firstNum / secondNum
                    } else {
                        textLabel.text = "エラー"
                        return
                    }
                default:
                    return
                }
                resultNumStr = String(result)
                textLabel.text = resultNumStr
                
                // 計算履歴を更新
                let newEntry = "\(firstNumStr) \(operatorStr) \(secondNumStr) = \(resultNumStr)"
                updateCalculationHistory(newEntry: newEntry)
                
                // 状態をリセット
                firstNumStr = ""
                secondNumStr = ""
                operatorStr = ""
                enteredFirstNumFlag = false
            }
        }
    }
    
    @IBAction func allClear(_ sender: UIButton) {
        firstNumStr = ""
        secondNumStr = ""
        operatorStr = ""
        textLabel.text = ""
        enteredFirstNumFlag = false
        print("All Clearが実行されました。")
    }
}
