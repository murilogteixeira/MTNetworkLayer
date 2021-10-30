//
//  TodosViewController.swift
//  Example
//
//  Created by Murilo Teixeira on 30/10/21.
//

import UIKit
import Combine

class TodosViewController: UIViewController {

    let mainView = TodosView()
    let viewModel: TodosViewModel
    var cancellable: AnyCancellable?

    init(viewModel: TodosViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.tableView.dataSource = self
        cancellable = viewModel.$state.sink { [weak self] in self?.viewModelStateHandler($0) }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getTodos()
    }

    func viewModelStateHandler(_ state: TodosViewModel.State) {
        switch state {
        case .initial: break
        case .todosUpdated:
            DispatchQueue.main.async {
                self.mainView.tableView.reloadData()
            }
        case .error(let error): print("ERROR: \(error)")
        }
    }
    
}

extension TodosViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.todos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: UITableViewCell.self, for: indexPath)

        let todo = viewModel.todos[indexPath.row]

        var configuration = cell.defaultContentConfiguration()
        configuration.text = todo.title
        configuration.secondaryText = todo.completed ? "Finalizado" : "Pendente"

        cell.contentConfiguration = configuration
        return cell
    }
}
