//
//  NetworkManager.swift
//  EarthquakeApp
//
//  Created by xzy on 2024/1/31.
//

import Foundation

/// define error types
enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case serverError
    case invalidData
    case decodeError
}

enum NetworkMethod: String {
    case get = "GET"
    case post = "POST"
}

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    /// request method
    /// - Parameters:
    ///   - url: url
    ///   - method: get/post
    ///   - success: success closure
    ///   - failure: failure closure with error type
    func request(urlString: String, method: NetworkMethod, success: @escaping (Data) -> Void, failure: @escaping (NetworkError) -> Void) {
        // handle invalid urlstring
        guard let url = URL(string: urlString) else {
            failure(.invalidURL)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    failure(.requestFailed(error))
                    return
                }
                // handle server error
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    failure(.requestFailed(NetworkError.serverError))
                    return
                }
                guard let data = data else {
                    failure(.invalidData)
                    return
                }
                /*
                 keep the function seperated
                 not just request for the https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=2023- 01-01&endtime=2024-01-01&minmagnitude=7
                 so throw the data outside then decode
                 */
                success(data)
            }
        }
        task.resume()
    }
}
