//
//  ViewController.swift
//  video
//
//  Created by Tomek Koszarek on 16/01/2024.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    @IBOutlet weak var videoContainerView: UIView!
    @IBOutlet weak var timeLabel: UILabel!

    var player: AVPlayer?
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func startButtonTapped(_ sender: UIButton) {
        var startTime = Date() // Start timing

        // Setup and play video
        let videoURL = Bundle.main.url(forResource: "video_example", withExtension: "mp4")
        player = AVPlayer(url: videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = videoContainerView.bounds
        videoContainerView.layer.addSublayer(playerLayer)
        
        player?.play()
        
        let elapsedTime = Date().timeIntervalSince(startTime)
        timeLabel.text = "Time: \(elapsedTime * 1000.0) ms"
    }
}

