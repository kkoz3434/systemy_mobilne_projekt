//
//  ViewController.swift
//  calculations
//
//  Created by Tomek Koszarek on 15/01/2024.
//

import UIKit

class ViewController: UIViewController {
    
    let start: Int = 1
    let end: Int = 10000
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func startButtonClicked(_ sender: Any) {
        let range = start...end
        let startTime = CFAbsoluteTimeGetCurrent()
    
        let primes = findPrimes(inRange: range)
        
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        timeLabel.text = "\(timeElapsed) s."
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func findPrimes(inRange range: ClosedRange<Int>) -> [Int] {
        return range.filter { isPrime($0) }
    }

    func isPrime(_ number: Int) -> Bool {
        if number <= 1 { return false }
        if number <= 3 { return true }
        
        for i in 2...Int(sqrt(Double(number))) {
            if number % i == 0 {
                return false
            }
        }
        return true
    }

}

