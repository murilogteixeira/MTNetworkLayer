//
//  JsonPlaceholderEndpoint.swift
//  Example
//
//  Created by Murilo Teixeira on 28/10/21.
//

import Foundation
import MTNetworkLayer

enum NetworkEvironment: String {
    case dev, prod
}

enum JsonPlaceholderApi {
    case todos
    case posts(id: Int? = nil)
    case comments(postId: Int? = nil)
    case users
}

extension JsonPlaceholderApi: EndpointType {

    static let environment: NetworkEvironment = .dev

    var environmentBaseURL: String {
        switch Self.environment {
        case .dev: return "https://jsonplaceholder.typicode.com"
        case .prod: return "https://jsonplaceholder.typicode.com"
        }
    }

    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.") }
        return url
    }

    var path: String {
        switch self {
        case .todos:
            return "todos"
        case .posts(let id):
            if let id = id { return "posts/\(id)" }
            return "posts"
        case .comments(let postId):
            if let postId = postId { return "posts/\(postId)/comments" }
            return "comments"
        case .users:
            return "users"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .todos: return .get
        case .posts: return .get
        case .comments: return .get
        case .users: return .get
        }
    }

    var task: HTTPTask {
        .request
    }

    var headers: HTTPHeaders? { nil }
}
