//
//  PlayerUIView.swift
//  Video
//
//  Created by Jlavyan on 3/27/20.
//  Copyright © 2020 Jlavyan. All rights reserved.
//

import UIKit
import AVKit

class PlayerUIView: UIView {
  private let playerLayer = AVPlayerLayer()

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
     fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    playerLayer.frame = bounds
  }
    
   func loadUrl(url urlString: String){
        let url = URL(string: urlString)!
    
        load(universalUrl: url)
    }
    
    func loadFileUrl(url urlString: String){
         let url = URL(fileURLWithPath: urlString)
     
         load(universalUrl: url)
     }
    
    private func load(universalUrl: URL){
        let player = AVPlayer(url: universalUrl)

        player.play()

        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerLayer.player = player
        layer.addSublayer(playerLayer)
    }
}
