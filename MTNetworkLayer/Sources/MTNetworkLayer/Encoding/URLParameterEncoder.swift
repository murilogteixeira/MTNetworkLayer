//
//  URLParameterEncoding.swift
//  MTNetworkLayer
//
//  Created by Murilo Teixeira on 28/10/21.
//

import Foundation

enum NetworkError: LocalizedError {
    case parametersNil
    case encodingFailed
    case missingURL

    var errorDescription: String? {
        switch self {
        case .parametersNil: return "Parameters were nil"
        case .encodingFailed: return "Parameters encoding failed"
        case .missingURL: return "URL is nil"
        }
    }
}

public struct URLParameterEncoding: ParameterEncoder {
    
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else { throw NetworkError.missingURL }

        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
           !parameters.isEmpty {

            urlComponents.queryItems = [URLQueryItem]()
            parameters.forEach { key, value in
                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }

        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue(
                "application/x-www-form-urlencoded; charset=utf-8",
                forHTTPHeaderField: "Content-Type"
            )
        }
    }
}
