//
//  VideoRoes.swift
//  Video
//
//  Created by Jlavyan on 3/27/20.
//  Copyright © 2020 Jlavyan. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct VideoRow: View {
    @ObservedObject var viewModel: VideoListViewModel
    @State var video: Video

    var body: some View {
        HStack {
            WebImage(url: URL(string: video.tnumbnail))
                .onSuccess { image, cacheType in
                    // Success
                }
                .resizable()
                .indicator(.activity)
                .animation(.easeInOut(duration: 0.5))
                .transition(.fade)
                .scaledToFit()
                .cornerRadius(3)
                .frame(width: 44, height: 44, alignment: .center)


            Text(video.name)
                .font(Font.system(size: 15))

            Spacer()
        }
            .frame(height: 60)
    }
}


