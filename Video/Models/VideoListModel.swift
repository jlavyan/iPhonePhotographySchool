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

final class VideoListViewModel: ObservableObject {
    var videoRepository = VideoRepository()
    
    @Published private(set) var videos = [Video]()
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
            switch error {
            case ApiError.conflict:
                print("Conflict error")
            case ApiError.forbidden:
                print("Forbidden error")
            case ApiError.notFound:
                print("Not found error")
            default:
                print("Unknown error:", error)
            }
        })
        .disposed(by: disposeBag)


    }

}
