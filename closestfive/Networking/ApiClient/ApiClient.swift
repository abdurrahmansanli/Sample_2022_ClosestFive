//
//  ApiClient.swift
//  closestfive
//
//  Created by Abdurrahman Şanlı on 21.05.2022.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

final class ApiClient {
    
    private let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
    private let baseUrl = "https://api.foursquare.com/v3/"
    private let token = "fsq3cj5xqxFW/ZXayTlXX+FOgrNfCnMX0+Lvm1jguNLKHSY="
    private let authorizationKey = "Authorization"
    
    func sendRequest<ResponseType:Decodable>(httpMethod: HttpMethod,
                                             responseType: ResponseType.Type,
                                             urlString: String,
                                             success: @escaping (ResponseType) -> Void,
                                             failure: @escaping () -> Void) {
        let requestUrlString = baseUrl + urlString
        guard let requestUrl = URL(string: requestUrlString) else { return }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = httpMethod.rawValue
        request.setValue(token, forHTTPHeaderField: authorizationKey)
        
        let task = session.dataTask(with: request, completionHandler: { (data: Data?,
                                                                         response: URLResponse?,
                                                                         error: Error?) -> Void in
            if let data = data {
                do {
                    let responseObject = try JSONDecoder().decode(ResponseType.self, from: data)
                    success(responseObject)
                } catch {
                    failure()
                }
            } else {
                failure()
            }
        })
        task.resume()
    }
}
