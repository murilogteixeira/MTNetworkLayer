//
//  Router.swift
//  MTNetworkLayer
//
//  Created by Murilo Teixeira on 28/10/21.
//

import Foundation

public typealias Completion<T> = ((Result<T, Error>) -> Void)

final public class Router<Endpoint: EndpointType>: NetworkerRouter {
    private var task: URLSessionTask?
    public var showLog: Bool = true

    public init() { }

    public func request<T: Decodable>(_ route: Endpoint, completion: @escaping Completion<T>) {
        let session = URLSession.shared

        do {
            let request = try buildRequest(from: route)

            if showLog { NetworkLogger.log(request: request) }

            task = session.dataTask(with: request) { [weak self] data, response, error in
                guard error == nil else {
                    completion(.failure(error!))
                    return
                }

                if self?.showLog ?? false { NetworkLogger.log(response: response, data: data) }

                if let response = response as? HTTPURLResponse,
                   let result = self?.handleNetworkResponse(response) {

                    switch result {
                    case .success:
                        if let value = true as? T {
                            completion(.success(value))
                            return
                        }

                        if let apiResponse: T = self?.decodeData(data) {
                            completion(.success(apiResponse))
                        } else {
                            completion(.failure(NetworkResponseError.unableToDecode))
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        } catch  {
            completion(.failure(error))
        }

        task?.resume()
    }

    func cancel() {
        task?.cancel()
    }

    private func buildRequest(from route: Endpoint) throws -> URLRequest {
        var request = URLRequest(
            url: route.baseURL.appendingPathComponent(route.path),
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: 10
        )

        request.httpMethod = route.httpMethod.rawValue

        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyParameters, let urlParameters):
                try configureParameters(
                    bodyParameters: bodyParameters,
                    urlParameters: urlParameters,
                    request: &request
                )
            case .requestParametersAndHeaders(let bodyParameters, let urlParameters, let additionalHeaders):
                addAdditionalHeaders(additionalHeaders, request: &request)
                try configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
            }
            return request
        } catch {
            throw error
        }
    }

    private func configureParameters(
        bodyParameters: Parameters?,
        urlParameters: Parameters?,
        request: inout URLRequest
    ) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }

            if let urlParameters = urlParameters {
                try URLParameterEncoding.encode(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }

    private func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
    }

    private func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<Int, Error> {
        switch response.statusCode {
        case 200...299: return .success(response.statusCode)
        case 400...499: return .failure(NetworkResponseError.authenticationError)
        case 500...599: return .failure(NetworkResponseError.badRequest)
        case 600: return .failure(NetworkResponseError.outdated)
        default: return .failure(NetworkResponseError.failed)
        }
    }

    private func decodeData<T: Decodable>(_ data: Data?) -> T? {
        if let data = data {
            let apiReponse = try? JSONDecoder().decode(T.self, from: data)
            return apiReponse
        }

        return nil
    }

}
