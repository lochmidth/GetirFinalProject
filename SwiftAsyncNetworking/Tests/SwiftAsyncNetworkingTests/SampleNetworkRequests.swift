//
//  File.swift
//
//
//  Created by Alphan Ogün on 9.04.2024.
//

import Foundation
@testable import SwiftAsyncNetworking

struct SampleRequestSuccess: NetworkRequestable {
    var baseURL: String {
        return "https://65c38b5339055e7482c12050.mockapi.io/"
    }
    var method: HTTPMethod {
        return .get
    }
    var path: String {
        return "api/suggestedProducts"
    }
}

struct SampleRequestFailure: NetworkRequestable {
    var baseURL: String {
        return "https://65c38b5339055e7482c12050/"
    }
    var method: HTTPMethod {
        return .get
    }
    var path: String {
        return "fail"
    }
}


