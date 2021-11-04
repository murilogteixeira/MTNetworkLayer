//
//  HTTPTask.swift
//  MTNetworkLayer
//
//  Created by Murilo Teixeira on 28/10/21.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPTask {
    case request

    case requestParametersAndHeaders(
        bodyParameters: Parameters? = nil,
        urlParameters: Parameters? = nil,
        additionalHeaders: HTTPHeaders? = nil
    )

//    case download, upload, etc...
}
