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
    @ObservedObject var viewModel = VideoListModel()
    @ObservedObject var downloadModel = VideoDownloadModel()
    
    var body: some View {
        RefreshableNavigationView(title: "Numbers", action:{
            self.viewModel.load()
        }){
            ForEach(self.viewModel.videos, id: \.self){ video in
                VStack {
                        NavigationLink(
                            destination: DetailView(video: video, downloadModel: self.downloadModel)
                        ) {
                            VideoRow(video: video)
                                .onAppear {
                        }
                }}.navigationBarTitle(Text("Videos"))
            }

        }.onAppear(){
            self.viewModel.load()
        }
    }
}

struct DetailView: View {
    @ObservedObject var downloadModel: VideoDownloadModel;

    var video: Video
    init(video: Video, downloadModel: VideoDownloadModel){
        self.video = video
        self.downloadModel = downloadModel
    }
    
    func action(video: Video){
        guard let state = self.downloadModel.states[video] else{
            downloadModel.download(video: video)
            return
        }
        
        if state == .loading{
            downloadModel.cancel(video: video)
        }
    }

    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
                PlayerView(video: video).frame(height: 250)
                Text(video.name).bold().font(Font.system(size: 20)).padding(10)
                Text(video.description).padding(10)
                Spacer()
            }.padding(.top, 140)
            }.navigationBarTitle(Text("")).navigationBarItems(trailing:
                HStack{ Button(loadTitle(video: video)) {
                    self.action(video: self.video)
                    }; loadImage(video: video)
                }
            ).edgesIgnoringSafeArea([.top, .bottom])
    }
    
    
    private func state(video: Video) -> LoadingState{
        if let _ = DefaultsStore.loadVideoPath(id: video.videoLink){
            return LoadingState.loaded
        }

        guard let state = self.downloadModel.states[video] else{
            return LoadingState.initial
        }

        return state
    }
    
    private func loadTitle(video: Video) -> String{
        return state(video: video).title()
    }
    
    private func loadImage(video: Video) -> some View{
        let image = Image(systemName: "square.and.arrow.down")
        switch state(video: video) {
        case .initial:
            return AnyView(image.foregroundColor(Color.blue))
        case .loaded:
            return AnyView(EmptyView())
        case .loading:
            return AnyView(EmptyView())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
