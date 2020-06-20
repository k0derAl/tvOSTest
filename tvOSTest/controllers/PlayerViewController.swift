//
//  PlayerViewController.swift
//  testTV
//
//  Created by Alexey Nikiforov on 19.06.2020.
//  Copyright © 2020 Alexey Nikiforov. All rights reserved.
//

import UIKit
import AVKit

class PlayerViewController: AVPlayerViewController {
    
    private let markerLayer = CALayer()
    var synchronizedLayer: AVSynchronizedLayer? = nil
    
    
    
    @objc func timeJumped (notification:NSNotification)
    {
        print("AVPlayerItemTimeJumped")
    }
    
    @objc func videoTime (time:Double)
    {
        if ((time>5.0)&&(time<10.0))
        {
            synchronizedLayer?.isHidden = false
        }
        else
        {
            synchronizedLayer?.isHidden = true
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayers()
        player = AVPlayer(url: NSURL(string: "http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8")! as URL)
        
        NotificationCenter.default.addObserver(self, selector: #selector(timeJumped), name: NSNotification.Name.AVPlayerItemTimeJumped, object: nil)
        
        player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 2), queue: DispatchQueue.main, using: { _ in (
            self.videoTime(time: self.player!.currentTime().seconds)
            );})
        
        setupLayers()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    func setupLayers() {
        guard let playerItem = player?.currentItem else { return }
        synchronizedLayer = AVSynchronizedLayer(playerItem: playerItem)
        synchronizedLayer?.isHidden = true
        synchronizedLayer?.frame = CGRect(x: 200, y: 200, width: 200, height: 100)
        synchronizedLayer?.backgroundColor = UIColor.blue.cgColor
        synchronizedLayer?.opacity = 0.5
        
        let myTextLayer = CATextLayer()
        myTextLayer.string = "My text"
        myTextLayer.foregroundColor = UIColor.cyan.cgColor
        myTextLayer.frame = synchronizedLayer!.bounds
        synchronizedLayer!.addSublayer(myTextLayer)
        
        view.layer.addSublayer(synchronizedLayer!)
        
        
    }
    
}
