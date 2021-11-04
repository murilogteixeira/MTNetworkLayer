//
//  NetworkManagerProtocols.swift
//  Example
//
//  Created by Murilo Teixeira on 30/10/21.
//

import Foundation
import MTNetworkLayer

private let todosRouter = Router<TodosApi>()

protocol TodosNetworkManager {
    func fetchTodos(completion: @escaping Completion<[Todo]>)
}

extension NetworkManager: TodosNetworkManager {
    func fetchTodos(completion: @escaping Completion<[Todo]>) {
        todosRouter.request(.todos, completion: completion)
    }
}
