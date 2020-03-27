//
//  VideoView.swift
//  Video
//
//  Created by Jlavyan on 3/27/20.
//  Copyright © 2020 Jlavyan. All rights reserved.
//

import SwiftUI
import AVKit

struct PlayerView: UIViewRepresentable {
    var video: Video
    init(video: Video) {
        self.video = video
    }
  func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {
  }

  func makeUIView(context: Context) -> UIView {
    let playerView = PlayerUIView(frame: .zero)
    
    if let videoPath = Database.loadVideoPath(id: video.videoLink){
        playerView.loadFileUrl(url: videoPath)
    }else{
        playerView.loadUrl(url: video.videoLink)
    }
    
    return playerView
  }
}
