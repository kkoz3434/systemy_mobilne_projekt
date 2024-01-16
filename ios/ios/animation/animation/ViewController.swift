//
//  ViewController.swift
//  animation
//
//  Created by Tomek Koszarek on 16/01/2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func startAnimation(_ sender: Any) {
        let startTime = CFAbsoluteTimeGetCurrent()

        UIView.animate(withDuration: 5.0, animations: {
            self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 6)
        }) { _ in
            let endTime = CFAbsoluteTimeGetCurrent()
            let timeElapsed = endTime - startTime
            self.timeLabel.text = "Time: \(timeElapsed) s"
        }
    }
}

