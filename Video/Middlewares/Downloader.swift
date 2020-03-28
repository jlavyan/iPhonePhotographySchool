//
//  Downloader.swift
//  Video
//
//  Created by Jlavyan on 3/27/20.
//  Copyright © 2020 Jlavyan. All rights reserved.
//

import Foundation
import RxSwift
import AVFoundation

class Downloader: NSObject, AVAssetDownloadDelegate{
    var hslion: HLSion?
    
    func cancel(){
        hslion?.cancelDownload()
    }
    
    func downloadData(video: Video) -> Observable<String>{
       return Observable<String>.create { observer in
        if let url = URL(string: video.videoLink){

        self.hslion = HLSion(url: url, name: String(video.id)).download { (progressPercentage) in
            print("Downloaded progress: \(progressPercentage)")
        }.finish { (relativePath) in
            Database.saveVideoPath(id: video.videoLink, path: relativePath)
            observer.onNext(video.videoLink)
            observer.onCompleted()
        }.onError { (error) in
            observer.onError(VideoRepositoryError.notFound)
            }
        }

        return Disposables.create {}
        }
    }
}

extension FileManager{

    func createTemporaryDirectory(id: String) throws -> URL {
        let url = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(id)

        try createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        return url
    }
}

