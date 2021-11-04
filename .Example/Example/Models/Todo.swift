//
//  Todo.swift
//  Example
//
//  Created by Murilo Teixeira on 30/10/21.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let todo = try? newJSONDecoder().decode(Todo.self, from: jsonData)

import Foundation

// MARK: - Todo
struct Todo: Codable {
    let userID, id: Int
    let title: String
    let completed: Bool

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, completed
    }
}
