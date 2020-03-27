//
//  VideoRoes.swift
//  Video
//
//  Created by Jlavyan on 3/27/20.
//  Copyright © 2020 Jlavyan. All rights reserved.
//

import SwiftUI

struct VideoRow: View {
    @ObservedObject var viewModel: VideoListViewModel
    @State var video: Video

    var body: some View {
        HStack {
            Text(video.name)
                .font(Font.system(size: 18).bold())

            Spacer()
            }
            .frame(height: 60)
    }
}

