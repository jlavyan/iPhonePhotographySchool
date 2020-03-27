//
//  Downloader.swift
//  Video
//
//  Created by Jlavyan on 3/27/20.
//  Copyright © 2020 Jlavyan. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

class Downloader{
    var request: DownloadRequest?
    
    func cancel(){
        request?.cancel()
    }
    
    func downloadData(video: Video) -> Observable<String>{
       return Observable<String>.create { observer in
        let fileURL = URL(fileURLWithPath: "")

        self.request = AF.download(video.videoLink, to: { _, _ in (fileURL, [])})
                .response { response in
                    switch (response.result) {
                       case .success( _):
                    observer.onNext(video.videoLink)
                    observer.onCompleted()
                        case .failure(let error):
                            print(error)
                            // TODO: handle error
                            observer.onError(VideoRepositoryError.notFound)
                    }

            }
            return Disposables.create {}
        }
    }

}
