//
//  VideoRepository.swift
//  Video
//
//  Created by Jlavyan on 3/27/20.
//  Copyright © 2020 Jlavyan. All rights reserved.
//

import Alamofire
import RxSwift

enum ApiError: Error {
    case forbidden              //Status code 403
    case notFound               //Status code 404
    case conflict               //Status code 409
    case internalServerError    //Status code 500
}

class VideoRepository: Repository{
    final var api: String
    init(api: String = "videos"){
        self.api = api
    }
    
    func videoList() -> Observable<[Video]>{
        return Observable<[Video]>.create { observer in
            let request = AF.request(self.path(), method: .get, parameters: nil, encoding: URLEncoding.queryString, headers: nil)
         .validate()
         .responseJSON { response in

            switch (response.result) {

               case .success( _):
                   var videos = [Video]()
                   if let fullDictionary = response.value as? [String: Any] {
                       if let videoDictionaries = fullDictionary["videos"] as? [[String: Any]]{
                           videos = videoDictionaries.compactMap { (dictionary) -> Video? in
                               return Video(dictionary: dictionary)
                           }
                       }
                   }
                   observer.onNext(videos)
                   observer.onCompleted()

                case .failure(let e):
                    // TODO: handle error
                    observer.onError(ApiError.notFound)
                   self.loadError(error: e)
            }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }

    private func loadError(error: AFError){
        print("Request error: \(error.localizedDescription)")
    }
    

    private func path() -> String{
        return "\(baseUrl)/\(api)"
    }
}



