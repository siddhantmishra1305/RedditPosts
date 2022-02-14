//
//  ServerRequestEnum.swift
//  Reddit
//
//  Created by Siddhant Mishra on 13/02/22.
//
//http://www.reddit.com/r/pics/.json?jsonp=
import Foundation

enum ServerRequest{
    case getPosts

    private enum HTTPMethod {
        case get
        case post
        case put
        case delete
        
        var value: String {
            
            switch self {
            case .get: return "GET"
            case .post: return "POST"
            case .put: return "PUT"
            case .delete: return "DELETE"
            }
        }
    }
    
    private var method:HTTPMethod{
        switch self {
        case .getPosts:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .getPosts:
            return "/r/pics/.json"
        }
    }
    
    func request() throws -> URLRequest? {
        var urlString = "\(Constants.baseUrl)\(path)"
        
        switch self {
        case .getPosts:
            let params : [String : String] = ["jsonp" : ""]
            
            encodeURL(path: &urlString, params: params)
            guard let url = URL(string: urlString) else{
                return nil
            }
            
            var urlRequest = URLRequest(url:url)
            urlRequest.httpMethod = method.value
            return urlRequest
        }
    }
    
    /// This function encodes parameters to a URL
    private func encodeURL(path:inout String, params:[String:String]){
        var component = URLComponents(string: path)
        var queryItemArr = [URLQueryItem]()
        for item in params.keys{
            queryItemArr.append(URLQueryItem(name: item, value: params[item]))
        }
        component?.queryItems = queryItemArr
        let editedComponents = component?.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        component?.percentEncodedQuery = editedComponents
        
        path = component?.url?.absoluteString ?? ""
        
    }
}
