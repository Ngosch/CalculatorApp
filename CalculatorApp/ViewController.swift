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
    
    // グラデーションレイヤーをプロパティとして保持
    let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // グラデーションの初期設定
        gradientLayer.frame = self.view.bounds
        updateGradientColors()
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        textLabel.text = ""
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
    
    @IBAction func pressNum(_ sender: UIButton) {
        // アニメーションの追加
        sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 6.0,
                       options: .allowUserInteraction,
                       animations: { [weak self] in
                        sender.transform = .identity
                       },
                       completion: nil)
        
        var pushed_num = (sender.titleLabel?.text)!
        print(pushed_num + "が入力されました。")
        if afterCaliuculationFlag {
            firstNumStr = resultNumStr
            secondNumStr = ""
            afterCaliuculationFlag = false
        }
        
        if enteredFirstNumFlag == false {
            firstNumStr += pushed_num
            textLabel.text = firstNumStr
        } else {
            secondNumStr += pushed_num
            textLabel.text = secondNumStr
        }
    }
    
    @IBAction func pressOperator(_ sender: UIButton){
        var pushed_arithmetic = (sender.titleLabel?.text)!
        print(pushed_arithmetic + "が入力されました。")
        if afterCaliuculationFlag {
            firstNumStr = resultNumStr
            secondNumStr = ""
            afterCaliuculationFlag = false
        }
        
        if enteredFirstNumFlag == false && firstNumStr != "" {
            operatorStr = pushed_arithmetic
            enteredFirstNumFlag = true
        } else if enteredFirstNumFlag && firstNumStr != "" {
            operatorStr = pushed_arithmetic
        }
    }
    
    @IBAction func pressEqual(_ sender: UIButton) {
        if firstNumStr != "" && secondNumStr != "" && operatorStr != "" {
            if let firstNumDouble = Double(firstNumStr), let secondNumDouble = Double(secondNumStr) {
                var resultNum: Double = 0.0
                switch operatorStr {
                case "+":
                    resultNum = firstNumDouble + secondNumDouble
                case "-":
                    resultNum = firstNumDouble - secondNumDouble
                case "*":
                    resultNum = firstNumDouble * secondNumDouble
                case "/":
                    if secondNumDouble != 0 {
                        resultNum = firstNumDouble / secondNumDouble
                    } else {
                        textLabel.text = "エラー！"
                        print("0で割ったため")
                        return
                    }
                default: break
                }
                // 小数点以下が0の場合は、整数として表示
                if floor(resultNum) == resultNum {
                    resultNumStr = String(format: "%.0f", resultNum)
                } else {
                    resultNumStr = String(resultNum)
                }
                textLabel.text = resultNumStr
                afterCaliuculationFlag = true
                enteredFirstNumFlag = false
                operatorStr = ""
                print(resultNumStr + "が出力されました。")
                
                // 計算結果を表示した後、グラデーションの色を更新
                updateGradientColors()
            }
        }
    }
    
    @IBAction func allClear(_ sender: UIButton) {
        firstNumStr = ""
        secondNumStr = ""
        operatorStr = ""
        resultNumStr = ""
        textLabel.text = ""
        enteredFirstNumFlag = false
        afterCaliuculationFlag = false
        print("All Clearが実行されました。")
    }
}
