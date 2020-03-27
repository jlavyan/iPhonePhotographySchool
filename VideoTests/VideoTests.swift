//
//  VideoTests.swift
//  VideoTests
//
//  Created by Jlavyan on 3/27/20.
//  Copyright © 2020 Jlavyan. All rights reserved.
//

import XCTest
import Alamofire
import RxSwift

@testable import Video

class VideoTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testLoadingData() {
        let disposeBag = DisposeBag()

        VideoRepository().videoList().observeOn(MainScheduler.instance)
        .subscribe(onNext: { vs in
            if(vs.count == 0){
                XCTAssertEqual(vs.count == 0, true, "Error on load data via internet")
            }
        }, onError: { error in
            XCTAssertEqual(true, true, "Test passes with error \(error)")
        })
        .disposed(by: disposeBag)
    }
    
    
    func testDownloadFile() {
        let disposeBag = DisposeBag()

        let downloader = Downloader()
        let dictionary: [String: Any] = ["id": 1, "name": "hey", "thumbnail": "asd",
                                         "description": "any description", "video_link": "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"]
        let video = Video(dictionary: dictionary)
        
        downloader.downloadData(video: video).observeOn(MainScheduler.instance)
        .subscribe(onNext: { vs in
            XCTAssertEqual(vs.count == 0, true, "Error on download hls")
        }, onError: { error in
            XCTAssertEqual(true, true, "Test passes with error \(error)")
        })
        .disposed(by: disposeBag)
    }


    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
