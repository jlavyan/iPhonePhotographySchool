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

final class VideoDownloadViewModel: ObservableObject {
    var pendingDownloads = [Video: Downloader]()
    
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
        pendingDownloads[video] = Downloader();
    }

    func cancel(video: Video) {
        pendingDownloads[video] = nil;
    }


}
