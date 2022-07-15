//
//  ApiService.swift
//  desafio
//
//  Created by MARCOS FELIPE SOARES ROCHA on 15/12/21.
//

import Foundation

public final class ApiService {

    public static var shared = ApiService()
    private init() {}

    public func getRepositorios(
        page: Int = 1,
        completion: @escaping (Result<Repositorios>) -> Void
    ) {

        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = "/search/repositories"
        components.queryItems = [
            URLQueryItem(name: "q", value: "language:Swift"),
            URLQueryItem(name: "page", value: String(page))
        ]

        guard let url = components.url else {

            completion(.error(message: nil))
            return
        }

        self.request(url: url, completion: completion)
    }

    public func getPullRequests(
        autor: String,
        repositorio: String,
        completion: @escaping (Result<PullRequests>) -> Void
    ) {

        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        let path = "/repos/\(autor)/\(repositorio)/pulls"
        components.path = path

        guard let url = components.url else {
            completion(.error(message: nil))
            return
        }

        self.request(url: url, completion: completion)
    }

    private func request<T: Decodable>(url: URL, completion: @escaping (Result<T>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            var result: Result<T>

            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }

            if let error = error {
                result = .error(message: error.localizedDescription)
                return
            }

            guard let data = data else {
                result = .error(message: nil)
                return
            }

            let decoder = JSONDecoder()

            do {
                let response = try decoder.decode(T.self, from: data)
                result = .success(result: response)
            } catch let DecodingError.dataCorrupted(context) {
                result = .error(message: context.debugDescription)
                print(context)
                return
            } catch let DecodingError.keyNotFound(key, context) {
                result = .error(message: context.debugDescription)
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                return
            } catch let DecodingError.valueNotFound(value, context) {
                result = .error(message: context.debugDescription)
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                return
            } catch let DecodingError.typeMismatch(type, context) {
                result = .error(message: context.debugDescription)
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
                return
            } catch let error as NSError {
                result = .error(message: error.localizedDescription)
                print("error: ", error)
                return
            }
        }
        task.resume()
    }

    public enum Result<T> {
        case success(result: T)
        case error(message: String?)
    }
}
