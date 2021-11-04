//
//  JSONParameterEncoder.swift
//  MTNetworkLayer
//
//  Created by Murilo Teixeira on 28/10/21.
//

import Foundation

public struct JSONParameterEncoder: ParameterEncoder {

    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw NetworkError.encodingFailed
        }
    }

    public static func encode<T: Encodable>(urlRequest: inout URLRequest, withObj obj: T) throws {
        do {
            let jsonAsData = try JSONEncoder().encode(obj)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw NetworkError.encodingFailed
        }
    }
}
