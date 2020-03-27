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
                    }; Image(systemName: "square.and.arrow.down")
                }
            ).edgesIgnoringSafeArea([.top, .bottom])
    }
    
    
    func loadTitle(video: Video) -> String{
        if let _ = Database.loadVideoPath(id: video.videoLink){
            return ""
        }
        
        guard let state = self.downloadModel.states[video] else{
            return "Download Video"
        }
        
        return state.title()
    }
    
    func loadImage(video: Video) -> Image?{
        if let _ = Database.loadVideoPath(id: video.videoLink){
            return nil
        }
        
        guard let state = self.downloadModel.states[video] else{
            return Image(systemName: "square.and.arrow.down")
        }
        
        if state == .initial{
            return Image(systemName: "square.and.arrow.down")
        }else {
            return nil
        }
    }

    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
