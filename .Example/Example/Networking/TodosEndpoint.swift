//
//  JsonPlaceholderEndpoint.swift
//  Example
//
//  Created by Murilo Teixeira on 28/10/21.
//

import Foundation
import MTNetworkLayer


enum TodosApi {
    case todos
}

extension TodosApi: EndpointType {

    var baseURL: URL {
        guard let url = URL(string: NetworkManager.environmentBaseURL) else { fatalError("baseURL could not be configured.") }
        return url
    }

    var path: String {
        switch self {
        case .todos:
            return "todos"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .todos: return .get
        }
    }

    var task: HTTPTask<Todo> {
        .request
    }

    var headers: HTTPHeaders? { nil }
}
