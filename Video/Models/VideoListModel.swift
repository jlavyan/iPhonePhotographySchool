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

final class VideoListModel: ObservableObject {
    @Published private(set) var videos = [Video]()

    private var videoRepository = VideoRepository()
    
    private let disposeBag = DisposeBag()

    private var searchCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }

    deinit {
        searchCancellable?.cancel()
    }

    func load() {
        videoRepository.videoList().observeOn(MainScheduler.instance)
        .subscribe(onNext: { vs in
            self.videos = vs
        }, onError: { error in
            // TODO: make actions for different error
        })
        .disposed(by: disposeBag)
    }
    

}
