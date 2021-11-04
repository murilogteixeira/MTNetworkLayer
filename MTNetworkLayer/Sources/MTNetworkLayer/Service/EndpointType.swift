//
//  EndpointType.swift
//  MTNetworkLayer
//
//  Created by Murilo Teixeira on 28/10/21.
//

import Foundation

public protocol EndpointType {
    associatedtype TaskTypeObj: Encodable
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask<TaskTypeObj> { get }
    var headers: HTTPHeaders? { get }
}
