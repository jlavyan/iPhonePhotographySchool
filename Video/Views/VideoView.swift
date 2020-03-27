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
    var url: String
    init(url: String) {
        self.url = url
    }
  func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {
  }

  func makeUIView(context: Context) -> UIView {
    let playerView = PlayerUIView(frame: .zero)
    playerView.loadUrl(url: url)
    return playerView
  }
}
