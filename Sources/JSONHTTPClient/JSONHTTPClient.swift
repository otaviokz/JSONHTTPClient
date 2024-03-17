// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

@available(iOS 13.0.0, *)
public protocol JSONHTTPClientType {
    func get<T: Decodable>(_ url: URL, headers httpHeaders: [String: String]?) async throws -> T
    func postJSON<T: Decodable>(_ url: URL, body: Data, httpHeaders: [String: String]?) async throws -> T
}

@available(iOS 13.0.0, *)
public struct JSONHTTPClient: JSONHTTPClientType {
    public static let shared = JSONHTTPClient()
    
    private init() {}
    
    public func get<T: Decodable>(_ url: URL, headers httpHeaders: [String: String]?) async throws -> T {
        try await connect(.get(url).headers(httpHeaders))
        
    }
    
    public func postJSON<T: Decodable>(_ url: URL, body: Data, httpHeaders: [String: String]?) async throws -> T {
        try await connect(.postJSON(body, to: url).headers(httpHeaders))
    }
}

@available(iOS 13.0.0, *)
private extension JSONHTTPClient {
    func connect<T: Decodable>(_ request: URLRequest) async throws -> T {
        let (data, rulResponse) = try await URLSession.shared.data(for: request)
        if let httpUrlResponse = rulResponse as? HTTPURLResponse {
            guard httpUrlResponse.statusCode == 200 else {
                throw  JSONHTTPClientError.http(code: httpUrlResponse.statusCode)
            }
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw JSONHTTPClientError.decode(error)
        }
    }
}


