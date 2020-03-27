//
//  ContentView.swift
//  Video
//
//  Created by Jlavyan on 3/27/20.
//  Copyright © 2020 Jlavyan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var dates = [Date]()
    @ObservedObject var viewModel = VideoListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.videos) {video in
                    VideoRow(viewModel: self.viewModel, video: video)
                        .onAppear {
//                            self.viewModel.fetchImage(for: user)
                    }
                }}.navigationBarTitle(Text("Videos"))
        }.onAppear(){
            self.viewModel.load()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
