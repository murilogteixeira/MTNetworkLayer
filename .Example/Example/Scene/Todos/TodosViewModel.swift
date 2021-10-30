//
//  TodosViewModel.swift
//  Example
//
//  Created by Murilo Teixeira on 30/10/21.
//

import Foundation
import Combine

class TodosViewModel {

    enum State {
        case initial
        case todosUpdated
        case error(String)
    }

    @Published var state = State.initial
    let networkManager: TodosNetworkManager
    var todos: [Todo] = [] { didSet { state = .todosUpdated } }

    init(networkManager: TodosNetworkManager) {
        self.networkManager = networkManager
    }

    func getTodos() {
        networkManager.fetchTodos { [weak self] result in
            switch result {
            case .success(let todos): self?.todos = todos
            case .failure(let error): self?.state = .error(error.localizedDescription)
            }
        }
    }
}
