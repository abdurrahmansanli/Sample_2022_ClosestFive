//
//  ApiClient.swift
//  closestfive
//
//  Created by Abdurrahman Şanlı on 21.05.2022.
//

import Foundation

final class ApiClient {

    private let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
    private let baseUrl = ""

    func sendRequest<ResponseType>(urlString: String,
                     success: @escaping (ResponseType) -> Void,
                     failure: @escaping () -> Void) {
        let requestUrlString = baseUrl + urlString
        guard let requestUrl = URL(string: requestUrlString) else { return }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"

        let task = session.dataTask(with: request, completionHandler: { (data: Data?,
                                                                         response: URLResponse?,
                                                                         error: Error?) -> Void in
            
        })
        task.resume()
    }
}
