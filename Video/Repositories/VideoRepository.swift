//
//  VideoRepository.swift
//  Video
//
//  Created by Jlavyan on 3/27/20.
//  Copyright © 2020 Jlavyan. All rights reserved.
//

import Alamofire
import RxSwift
import Reachability

enum VideoRepositoryError: Error {
    case notFound // 404
    case noData
}

class VideoRepository: Repository{
    
    final var api: String

    init(api: String = "videos"){
        self.api = api
    }
    
    func videoList() -> Observable<[Video]>{
        let isReachable = try? Reachability.init().connection != .unavailable
        if isReachable == true{
            return loadOnline()
        }else{
            return loadOffline()
        }
    }

    private func loadOnline() -> Observable<[Video]>{
        Observable<[Video]>.create { observer in
            let request = AF.request(self.path(), method: .get, parameters: nil, encoding: URLEncoding.queryString, headers: nil)
         .validate()
         .responseJSON { response in

            switch (response.result) {
               case .success( _):
                   var videos = [Video]()
                   if let fullDictionary = response.value as? [String: Any] {
                    
                    // Save Data
                    Database.save(dictionary: fullDictionary)
                    
                    videos = self.loadVideos(dictionary: fullDictionary)
                   }
                   observer.onNext(videos)
                   observer.onCompleted()

                case .failure(let e):
                    // TODO: handle error
                    print(e)
                    observer.onError(VideoRepositoryError.notFound)
            }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    private func loadOffline() -> Observable<[Video]>{
        return Observable<[Video]>.create { observer in
            guard let dictionary = Database.loadDictionary() else{
                observer.onError(VideoRepositoryError.noData)
                return Disposables.create {}
            }
            let videos = self.loadVideos(dictionary: dictionary)

            observer.onNext(videos)
            observer.onCompleted()
            return Disposables.create {}
        }
    }
    
    
    private func loadVideos(dictionary: [String: Any]) -> [Video]{
        if let videoDictionaries = dictionary["videos"] as? [[String: Any]]{
                return videoDictionaries.compactMap { (dictionary) -> Video? in
                return Video(dictionary: dictionary)
            }
        }

        return [Video]()
    }
    
    
    private func path() -> String{
        return "\(baseUrl)/\(api)"
    }
}



