//
//  NetworkRouter.swift
//  MTNetworkLayer
//
//  Created by Murilo Teixeira on 28/10/21.
//

import Foundation

typealias NetworkerRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void

protocol NetworkerRouter: AnyObject {
    associatedtype Endpoint = EndpointType
    func request<T: Decodable>(_ route: Endpoint, completion: @escaping ((Result<T, Error>) -> Void))
    func cancel()
}

enum NetworkResponseError: String, LocalizedError {
    case authenticationError
    case badRequest
    case outdated
    case failed
    case noData
    case unableToDecode
    case noConnection

    var errorDescription: String? {
        switch self {
        case .authenticationError: return "You need to be authenticated first"
        case .badRequest: return "Bad request"
        case .outdated: return "The url you requested is outdated"
        case .failed: return "Network request failed"
        case .noData: return "Response returned with no data to decode"
        case .unableToDecode: return "We could not decode the response"
        case .noConnection: return "Please check your network connection"
        }
    }
}
