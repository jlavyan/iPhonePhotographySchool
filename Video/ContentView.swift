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
    @ObservedObject var downloadModel = VideoDownloadViewModel()

    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.videos) {video in
                    NavigationLink(
                        destination: DetailView(video: video, downloadModel: self.downloadModel)
                    ) {
                        VideoRow(viewModel: self.viewModel, video: video)
                            .onAppear {
                        }
                    }
                }}.navigationBarTitle(Text("Videos"))
        }.onAppear(){
            self.viewModel.load()
        }
    }
}

struct DetailView: View {
    @ObservedObject var downloadModel: VideoDownloadViewModel;

    var video: Video
    init(video: Video, downloadModel: VideoDownloadViewModel){
        self.video = video
        self.downloadModel = downloadModel
    }
    
    func action(video: Video){
        downloadModel.download(video: video)
    }

    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
                PlayerView(url: video.videoLink).frame(height: 250)
                Text(video.name).bold().font(Font.system(size: 20)).padding(10)
                Text(video.description).padding(10)
                Spacer()
            }.padding(.top, 140)
            }.navigationBarTitle(Text("")).navigationBarItems(trailing:
                HStack{ Button("Download Video") {
                    self.action(video: self.video)
                    }; Image(systemName: "square.and.arrow.down")
                }
            ).edgesIgnoringSafeArea([.top, .bottom])
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
