//
//  NetworkManager.swift
//  FinancialApp
//
//  Created by Murilo Teixeira on 28/10/21.
//

import Foundation
import MTNetworkLayer

class NetworkManager {
    
    private let router = Router<JsonPlaceholderApi>()

    public init(showLog: Bool = true) {
        router.showLog = showLog
    }

}

extension NetworkManager: TodosNetworkManager {
    func fetchTodos(completion: @escaping Completion<[Todo]>) {
        router.request(.todos, completion: completion)
    }
}

extension NetworkManager: CommentsNetworkManager {
    func fetchComments(postId: Int? = nil, completion: @escaping Completion<[Comment]>) {
        router.request(.comments(postId: postId), completion: completion)
    }
}

extension NetworkManager: UsersNetworkManager {
    func fetchUsers(completion: @escaping Completion<[User]>) {
        router.request(.users, completion: completion)
    }
}

extension NetworkManager: PostsNetworkManager {
    func fetchPost(id: Int? = nil, completion: @escaping Completion<[Post]>) {
        router.request(.posts(id: id), completion: completion)
    }
}
