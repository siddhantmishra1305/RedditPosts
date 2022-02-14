//
//  RedditTests.swift
//  RedditTests
//
//  Created by Siddhant Mishra on 14/02/22.
//

import XCTest
@testable import Reddit

class RedditTests: XCTestCase {
    
    func testGetPosts_success(){
        let serverMock = ServerManagerMock_success()
        let postVM = PostViewModel(serverManager: serverMock)
        
        postVM.getPosts { isSuccess, message in
            XCTAssertTrue(isSuccess)
            XCTAssertEqual(postVM.allPosts?.count,1)
        }
    }
    
    func testGetManufacturers_Failure(){
        let serverMock = ServerManagerMock_failure()
        let postVM = PostViewModel(serverManager: serverMock)
        
        postVM.getPosts { isSuccess, message in
            XCTAssertFalse(isSuccess)
            XCTAssertNotNil(message)
            XCTAssertEqual(postVM.allPosts?.count,0)
        }
    }
    
    
}
