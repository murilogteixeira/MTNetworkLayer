//
//  NetworkManager.swift
//  FinancialApp
//
//  Created by Murilo Teixeira on 28/10/21.
//

import Foundation
import MTNetworkLayer

class NetworkManager {

    enum Evironment: String {
        case dev, prod
    }
    static let environment: Evironment = .dev

    static var environmentBaseURL: String {
        switch Self.environment {
        case .dev: return "https://jsonplaceholder.typicode.com"
        case .prod: return "https://jsonplaceholder.typicode.com"
        }
    }

    public init() { }

}
