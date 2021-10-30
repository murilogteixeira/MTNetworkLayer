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

    case requestParameters(
        bodyParameters: Parameters?,
        urlParameters: Parameters?
    )

    case requestParametersAndHeaders(
        bodyParameters: Parameters?,
        urlParameters: Parameters?,
        additionalHeaders: HTTPHeaders?
    )

//    case download, upload, etc...
}
