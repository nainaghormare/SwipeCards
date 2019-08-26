//
//  VideoViewController.swift
//  VideoDating
//
//  Created by Naina Ghormare on 8/22/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideoViewController: BaseViewController {
    
    class func initiateController() -> VideoViewController {
        let storyboard  = UIStoryboard(name: "Dashboard", bundle: nil)
        let controller  = storyboard.instantiateViewController(withIdentifier: "VideoViewController") as! VideoViewController
        return controller
    }
    
    @IBOutlet weak var videoView    : UIView!
    @IBOutlet weak var lblTimer     : UILabel!
    
    var timer                       = Timer()
    var timerDuration: Int          = 12
    var theTimer                    = (h: 0, m: 0, s: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        playVideo()
    }
    
    private func playVideo() {
        guard let path      = Bundle.main.path(forResource: "movie", ofType:"mp4") else {
            debugPrint("movie.mp4 not found")
            return
        }
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        let player          = AVPlayer(url: URL(fileURLWithPath: path)) // your video url
        let playerLayer     = AVPlayerLayer(player: player)
        playerLayer.frame   = videoView.bounds
        videoView.layer.addSublayer(playerLayer)
        player.play()
        self.theTimer       = self.timerDuration.secondsToHoursMinutesSeconds()
        self.timer          = Timer.scheduledTimer(timeInterval: 1   , target: self, selector: #selector(self.counter), userInfo: nil, repeats: true)
       
    }
    
    @objc func playerDidFinishPlaying() {
        let controller = IntroViewController.initiateController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func counter() {
        timerDuration -= 1
        if timerDuration == 0 {
            timer.invalidate()
        } else {
            theTimer            = timerDuration.secondsToHoursMinutesSeconds()
            let displayTimer    = (String(format: "%02d:%02d", theTimer.m, theTimer.s))
            lblTimer.text       = displayTimer
        }
    }
    
}
