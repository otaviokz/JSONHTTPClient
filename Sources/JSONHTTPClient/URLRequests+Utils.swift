//
//  URLRequests+Utils.swift
//
//
//  Created by Otávio Zabaleta on 17/03/2024.
//

import Foundation

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
}

extension URLRequest {
    private func method(_ method: HTTPMethod) -> URLRequest {
        var request = self
        request.httpMethod = method.rawValue
        return request
    }
    
    func body(_ body: Data) -> URLRequest {
        var request = self
        request.httpBody = body
        return request
    }
    
    static func postData(_ body: Data, to url: URL) -> URLRequest {
        URLRequest(url: url).method(.post).body(body)
    }
    
    static func postJSON(_ body: Data, to url: URL) -> URLRequest {
        postData(body, to: url).withJSONHeaders()
    }
    
    @inlinable func headers(_ headers: [String: String]?) -> Self {
        guard let headers = headers else { return self }
        var new = self//editable()
        for (field, value) in headers {
            new.setValue(value, forHTTPHeaderField: field)
        }
        return new
    }
    
    @inlinable func withJSONHeaders() -> Self {
        headers(["application.json": "Content-Type"])
    }
    
    static func get(_ url: URL, cachePolicy: CachePolicy = .useProtocolCachePolicy) -> URLRequest {
        URLRequest(url: url, cachePolicy: cachePolicy).method(.get)
    }
}
