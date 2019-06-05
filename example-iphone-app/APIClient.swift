//
//  APIClient.swift
//  example-iphone-app
//
//  Created by Johannes Aram Unruh on 13.05.19.
//  Copyright © 2019 Johannes Aram Unruh. All rights reserved.
//

import Foundation

class APIClient {
    static func fetch() {
        let url = URL(string: "https://httpbin.org/get")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("data: \(dataString)")
                }
            }
        }
        task.resume()
    }
    
    static func post(_ token_id: String) {
        let url = URL(string: "https://172.22.1.170:3000")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("data: \(dataString)")
                }
            }
        }
        task.resume()
    }
}
