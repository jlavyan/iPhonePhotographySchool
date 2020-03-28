//
//  VideoTests.swift
//  VideoTests
//
//  Created by Jlavyan on 3/27/20.
//  Copyright © 2020 Jlavyan. All rights reserved.
//

import XCTest
import RxSwift
import RxTest

@testable import Video

class VideoTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }


    func testLoadingData() {
        let expectation = XCTestExpectation(description: "Load video JSON")

        let scheduler = TestScheduler(initialClock: 0)
        let results = scheduler.createObserver([Video].self)
        
        let observer = VideoRepository().videoList()
        observer.subscribe(results).disposed(by: DisposeBag())
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
            XCTAssertTrue(results.events.first?.value.element?.count != 0)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 7.0)
    }
    
    
    
    func testDownloadFile() {
        let expectation = XCTestExpectation(description: "Load video JSON")

        let disposeBag = DisposeBag()

        let downloader = Downloader()
        let dictionary: [String: Any] = ["id": 1, "name": "hey", "thumbnail": "asd",
                                         "description": "any description", "video_link": "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"]
        let video = Video(dictionary: dictionary)
        
        downloader.downloadData(video: video).observeOn(MainScheduler.instance)
        .subscribe(onNext: { vs in
            expectation.fulfill()
        }, onError: { error in
            XCTAssertTrue(false)
        })
        .disposed(by: disposeBag)
        
        
        wait(for: [expectation], timeout: 600.0)
    }


    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
