//
//  JSONHTTPClientError.swift
//
//
//  Created by Otávio Zabaleta on 17/03/2024.
//

import Foundation

public enum JSONHTTPClientError: Error {
    case decode(Error)
    case http(code: Int)
}
