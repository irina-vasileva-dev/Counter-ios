//
//  ViewController.swift
//  Counter
//
//  Created by Irina Vasileva on 11.03.2025.
//

import UIKit

class ViewController: UIViewController {

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { .portrait }
    
    @IBOutlet weak var countNumberLabel: UILabel!
    
    @IBOutlet weak var changeHistoryTextView:UITextView!
    
    @IBOutlet weak var incrementButton: UIButton!
    
    @IBOutlet weak var decrementButton: UIButton!
    
    //переменная для хранения значения счетчика
    private var counter = 0 {
        didSet {
            countNumberLabel.text = "\(counter)"
        }
    }
 
    /*
     * ключ для сохранения истории в UserDefaults
     */
    private let historyKey = "counterHistory"
    
    /*
     * массив для хранения истории изменений
     */
    private var history: [String] = [] {
        didSet {
            UserDefaults.standard.set(history, forKey: historyKey)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        incrementButton.setTitleColor(.white, for: .normal)
        incrementButton.backgroundColor = .red
        incrementButton.layer.cornerRadius = 10
        incrementButton.layer.masksToBounds = true
        decrementButton.setTitleColor(.white, for: .normal)
        decrementButton.backgroundColor = .systemBlue
        decrementButton.layer.cornerRadius = 10
        decrementButton.layer.cornerRadius = 10
        countNumberLabel.text = "0"
        loadHistory()
        updateHistoryTextView()
        changeHistoryTextView.isEditable = false
    }
    
    /*
     * действие при нажатии на кнопку "+"
     */
    @IBAction func
    incrementBtnTapped(_ sender: UIButton, forEvent event: UIEvent) {
        counter += 1
        let message = "[\(getCurrentDateTime())]: значение изменено на +1"
        updateHistory(with: message)
    }
    
    /*
     * действие при нажатии на кнопку "-"
     */
    @IBAction func
    decrementBtnTapped(_ sender: UIButton) {
        if counter > 0 {
            counter -= 1
            
            let message = "[\(getCurrentDateTime())]: значение изменено на -1"
            updateHistory(with: message)
        } else {
            let message = "[\(getCurrentDateTime())]: попытка уменьшить значение счетчика ниже 0"
            updateHistory(with: message)
        }
    }
    
    /*
     * действие при нажатии на кнопку "сбросить"
     */
    @IBAction func
    refreshBtnTapped(_ sender: UIButton) {
        counter = 0
        let message = "[\(getCurrentDateTime())]: значение сброшено"
        updateHistory(with: message)
    }
    
    /*
     * действие при нажатии на кнопку "корзина"
     */
    @IBAction func cleanRecordsBtnTapped(_ sender: UIButton) {
        clearHistory()
    }
    
    /*
     * функция для обновления текстового поля с историей
     */
    private func updateHistoryTextView() {
        changeHistoryTextView.text = history.joined(separator: "\n")
    }
    /*
     * функция для обновления истории изменений
     */
    private func updateHistory(with message: String) {
        history.append(message)
        updateHistoryTextView()
        
        let range = NSRange(location: changeHistoryTextView.text.count - 1, length: 1)
        
        changeHistoryTextView.scrollRangeToVisible(range)
    }
    
    /*
     * функция для загрузки истории изменений из UserDefaults
     */
    private func loadHistory() {
        if let savedHistory = UserDefaults.standard.array(forKey: historyKey) as? [String] {
            history = savedHistory
        }
        else {
            history = ["История изменений: "]
        }
    }
    
    /*
     * функция очистки историй изменений
     */
    private func clearHistory() {
        history = ["История изменений: "]
        updateHistoryTextView()
        UserDefaults.standard.removeObject(forKey: historyKey)
    }
    
    /*
     * функция для получения текущей даты и времени и форматирования в нужный вид
     */
    private func getCurrentDateTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        return formatter.string(from: Date())
    }
}

