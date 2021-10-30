//
//  TodosView.swift
//  Example
//
//  Created by Murilo Teixeira on 30/10/21.
//

import UIKit
import MTFoundation
import MTAutoLayoutKit

class TodosView: UIView {

    let tableView = UITableView()

    init() {
        super.init(frame: .zero)
        setupViewCode()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TodosView: ViewCode {
    func setupHierarchy() {
        addSubview(tableView)
    }

    func setupConstraints() {
        tableView.pinEdge.to(self)
    }

    func setupAdditionalConfiguration() {
        tableView.register(cellClass: UITableViewCell.self)
    }

}
