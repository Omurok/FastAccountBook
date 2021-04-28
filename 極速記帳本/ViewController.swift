//
//  ViewController.swift
//  極速記帳本
//
//  Created by Omurok Chien on 2021/4/28.
//

import UIKit

class ViewController: UIViewController {

    
    //定義UIStoryBoard上 各UI元件  Outlet
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var recordCountLabel: UILabel!
    
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var addIncomeBtnOutlet: UIButton!
    @IBOutlet weak var incomeDetailBtnOutlet: UIButton!
    
    @IBOutlet weak var expenseLabel: UILabel!
    @IBOutlet weak var addExpenseBtnOutlet: UIButton!
    @IBOutlet weak var expenseDetailBtnOutlet: UIButton!
    
    @IBOutlet weak var resetBtnOutlet: UIButton!
    
    
    //MARK:宣告會用到的變數
    
    //總Balance
    var totalBalance:Int = 0
    
    //收入部分 一個總收入 一個收入Array
    var totalIncome:Int = 0
    var incomes:[Int] = []
    
    //支出部分 一個總支出 一個支出Array
    var totalExpense:Int = 0
    var expenses:[Int] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK:Function們
    func balanceCalculator(){
        //計算總支出、收入、總收支
        
        //收入部分
        totalIncome = 0 //先將變數歸零
        //在Array迴圈 做每一項的計算
        for income in incomes{
            totalIncome += income
        }
        print("TotalIncome = ",totalIncome)
        
        //支出部分
        totalExpense = 0 //先將變數歸零
        //在Array迴圈 做每一項的計算
        for expense in expenses{
            totalExpense += expense
        }
        print("TotalExpense = ",totalExpense)
        
        //計算總支出
        totalBalance = totalIncome - totalExpense
     
        //計算後呼叫 updateDisplay更新畫面
        updateDisplay()
    }
    
    //更新顯示
    func updateDisplay(){
        DispatchQueue.main.async {
            self.balanceLabel.text = "$" +  String(self.totalBalance)
            
            self.expenseLabel.text = "$" +  String(self.totalExpense)
            
            self.incomeLabel.text = "$" +  String(self.totalIncome)
        }
    }
    
    
    
    //收入類按鈕
    @IBAction func addIncomeAction(_ sender: Any) {
        let alert = UIAlertController(title: "增加一筆收入", message: nil, preferredStyle: .alert)
       alert.addTextField { textField in
            textField.keyboardType = .numberPad
        }
        let ok = UIAlertAction(title: "輸入", style: .default) { act in
            if let tf = alert.textFields?.first,let validValue = Int(tf.text!){
                self.incomes.append(validValue)
                self.balanceCalculator()
            }
        }
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func incomeDetailAction(_ sender: Any) {
        var message = ""
        var i = 1
        for income in incomes{
            message += "\(i):$ \(income)\n"
            i += 1
        }
        let prompt = UIAlertController(title: "收入列表:共\(incomes.count)筆資料", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "確定", style: .default, handler: nil)
        prompt.addAction(ok)
        self.present(prompt, animated: true, completion: nil)
    }
    
    //支出類按鈕
    
    @IBAction func addExpenseAction(_ sender: Any) {
        let alert = UIAlertController(title: "增加一筆支出", message: nil, preferredStyle: .alert)
       alert.addTextField { textField in
            textField.keyboardType = .numberPad
        }
        let ok = UIAlertAction(title: "輸入", style: .default) { act in
            if let tf = alert.textFields?.first,let validValue = Int(tf.text!){
                self.expenses.append(validValue)
                self.balanceCalculator()
            }
        }
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func expenseDetailAction(_ sender: Any) {
        var message = ""
        var i = 1
        for expense in expenses{
            message += "\(i):$ \(expense)\n"
            i += 1
        }
        let prompt = UIAlertController(title: "支出列表:共\(expenses.count)筆資料", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "確定", style: .default, handler: nil)
        prompt.addAction(ok)
        self.present(prompt, animated: true, completion: nil)
    }
    
    
    
    
    
    //重置按鈕
    @IBAction func resetBtnAction(_ sender: Any) {
        let alert = UIAlertController(title: "重置", message: "確定要重置您的紀錄？", preferredStyle: .actionSheet)
        let ok = UIAlertAction(title: "確定", style: .destructive) { _ in
            self.incomes = []
            self.expenses = []
            self.balanceCalculator()
        }
        let cancel = UIAlertAction(title: "取消", style: .default, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    func setupUI(){
        let allBtn = [addIncomeBtnOutlet,incomeDetailBtnOutlet,addExpenseBtnOutlet,expenseDetailBtnOutlet,resetBtnOutlet]
        for btn in allBtn{
            btn?.layer.cornerRadius = 8
            btn?.layer.borderWidth = 2
            btn?.layer.borderColor = UIColor.white.cgColor
            btn?.layer.shadowColor = UIColor.black.cgColor
            btn?.layer.shadowOffset = CGSize(width: 3, height: 2)
            btn?.layer.shadowRadius = 3
            btn?.layer.shadowOpacity = 0.6
            btn?.layer.masksToBounds = false
        }
    }
    
}

