//
//  VideoModel.swift
//  Video
//
//  Created by Jlavyan on 3/27/20.
//  Copyright © 2020 Jlavyan. All rights reserved.
//

import Foundation
import Combine
import RxSwift

enum LoadingState{
    case initial
    case loading
    case loaded;
    
    func title() -> String{
        switch self{
        case .initial:
            return "Download Video"
        case .loading:
            return "Cancel download"
        case .loaded:
            return ""
        }
    }
}

final class VideoDownloadModel: ObservableObject {
    @Published private(set) var states = [Video: LoadingState]()

    private var pendingDownloads = [Video: Downloader]()
    private let disposeBag = DisposeBag()

    private var searchCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }

    deinit {
        searchCancellable?.cancel()
    }

    func isInDownload(video: Video) -> Bool{
        return pendingDownloads[video] != nil
    }
    
    func download(video: Video) {
        // Change state
        states[video] = .loading
        
        // Change state after download
        let downloader = Downloader()
        downloader.downloadData(video: video).observeOn(MainScheduler.instance)
        .subscribe(onNext: { vs in
            self.states[video] = .loaded
        }, onError: { error in
            // TODO: make actions for different error
        })
        .disposed(by: disposeBag)
        pendingDownloads[video] = downloader;
    }

    func cancel(video: Video) {
        // Cancel download
        pendingDownloads[video]?.cancel()
        
        // Clean data
        states[video] = nil
        pendingDownloads[video] = nil;
    }
}
