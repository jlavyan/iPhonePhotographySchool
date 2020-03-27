//
//  VideoRepository.swift
//  Video
//
//  Created by Jlavyan on 3/27/20.
//  Copyright © 2020 Jlavyan. All rights reserved.
//

import Foundation
import Alamofire

class VideoRepository: Repository{
    final var api: String
    init(api: String = "videos"){
        self.api = api
    }
    
    func videoList(success: @escaping ([Video]) -> Void, error: @escaping () -> Void){
        AF.request(path(), method: .get, parameters: nil, encoding: URLEncoding.queryString, headers: nil)
         .validate()
         .responseJSON { response in

            switch (response.result) {

                case .success( _):

                do {
                    let videos = try JSONDecoder().decode([Video].self, from: response.data!)
                    success(videos)
                } catch let error as NSError {
                    self.loadError(error: error)
                    error()
                }
                 case .failure(let error):
                    self.loadAFError(error: error)
                    error()
             }

        }
    }
    
    private func loadError(error: NSError){
        print("Request error: \(error.localizedDescription)")
    }
    
    private func loadAFError(error: AFError){
        print("Request error: \(error.localizedDescription)")
    }

    private func path() -> String{
        return "\(baseUrl)/api"
    }
}

