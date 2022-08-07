//
//  APIClient.swift
//  UIKitCombineExample
//
//  Created by Kotaro Fukuo on 2022/08/06.
//

import Foundation

protocol APIRequestable {
    func request(urlString: String) async throws -> Body
}

enum APIRequestError: Error {
    case statusCode
}

struct APIClient: APIRequestable {
    func request(urlString: String) async throws -> Body {
        let (data, response) = try await URLSession.shared.data(from: URL(string: urlString)!)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIRequestError.statusCode
        }
        return try JSONDecoder().decode(Body.self, from: data)
    }
}
