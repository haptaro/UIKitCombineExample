import Foundation

public protocol APIRequestable {
    func request(urlString: String) async throws -> Body
}

public enum APIRequestError: Error {
    case statusCode
}

public struct APIClient: APIRequestable {
    public init() {}
    
    public func request(urlString: String) async throws -> Body {
        let (data, response) = try await URLSession.shared.data(from: URL(string: urlString)!)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIRequestError.statusCode
        }
        return try JSONDecoder().decode(Body.self, from: data)
    }
}
