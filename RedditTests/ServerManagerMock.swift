//
//  ServerManagerMock.swift
//  RedditTests
//
//  Created by Siddhant Mishra on 14/02/22.
//

import Foundation
@testable import Reddit
import XCTest

typealias ServerRequestRecievedBlock = () -> Void

class ServerManagerMock_success:ServerManagerProtocol{

    func request<T>(config: URLSessionConfiguration, router: ServerRequest, completion: @escaping (Result<T, NetworkError>) -> ()) where T : Decodable{
        // prepare dummy data
        let postValue = PostInfo(author_fullname: "test", title: "test_title", thumbnail: "test_thumbnail", created: 0, url_overridden_by_dest:"test" , description: "test")
        let childData = Children(postInfo: postValue, kind: "test")
        let postData = PostData(allPosts: [childData])
        let redditResponse = RedditResponse(postData: postData, kind: "test")
        
        XCTAssertNotNil(router.request)
        XCTAssertEqual(config, .default)
        completion(.success(redditResponse as! T))
    }
}

class ServerManagerMock_failure:ServerManagerProtocol{
    
    func request<T>(config: URLSessionConfiguration, router: ServerRequest, completion: @escaping (Result<T, NetworkError>) -> ()) where T : Decodable{
        XCTAssertNotNil(router.request)
        XCTAssertEqual(config, .default)
        completion(.failure(.parsingError))
    }
}
