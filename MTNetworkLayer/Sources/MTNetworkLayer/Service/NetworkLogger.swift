//
//  NetworkLogger.swift
//  MTNetworkLayer
//
//  Created by Murilo Teixeira on 28/10/21.
//

import Foundation

class NetworkLogger {
    static func log(request: URLRequest) {

        print("\n - - - - - - - - - - BEGIN REQUEST - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END REQUEST - - - - - - - - - - \n") }

        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = URLComponents(string: urlAsString)

        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"

        var logOutput = """
                        \(urlAsString) \n\n
                        \(method) \(path)?\(query) HTTP/1.1 \n
                        HOST: \(host)\n
                        """

        request.allHTTPHeaderFields?.forEach { key, value in
            logOutput += "\(key): \(value) \n"
        }

        if let body = request.httpBody {
            logOutput += "\n \(String(data: body, encoding: .utf8) ?? "")"
        }

        print(logOutput)
    }

    static func log(response: URLResponse?, data: Data?) {

        print("\n - - - - - - - - - - BEGIN RESPONSE - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END RESPONSE - - - - - - - - - - \n") }

        guard let response = response as? HTTPURLResponse else { return }

        let urlAsString = response.url?.absoluteString ?? ""
        let urlComponents = URLComponents(string: urlAsString)

        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"

        var logOutput = """
                        \(urlAsString) \n\n
                        \(path)?\(query)\n
                        STATUS CODE: \(response.statusCode)
                        HOST: \(host)\n
                        """

        response.allHeaderFields.forEach { key, value in
            logOutput += "\(key): \(value) \n"
        }

        if let data = data {
            if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
               let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                logOutput += "\n \(String(data: jsonData, encoding: .utf8) ?? "")"
            } else {
                print("json data malformed")
            }
        }

        print(logOutput)
    }
}
