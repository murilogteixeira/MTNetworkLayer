//
//  NetworkManagerProtocols.swift
//  Example
//
//  Created by Murilo Teixeira on 30/10/21.
//

import Foundation
import MTNetworkLayer

protocol TodosNetworkManager {
    func fetchTodos(completion: @escaping Completion<[Todo]>)
}

protocol UsersNetworkManager {
    func fetchUsers(completion: @escaping Completion<[User]>)
}

protocol CommentsNetworkManager {
    func fetchComments(postId: Int?, completion: @escaping Completion<[Comment]>)
}

protocol PostsNetworkManager {
    func fetchPost(id: Int?, completion: @escaping Completion<[Post]>)
}
