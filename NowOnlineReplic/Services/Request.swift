//
//  Request.swift
//  NowOnlineReplic
//
//  Created by William Tristão de Pauloa on 18/11/21.
//

import Foundation

class Request {
    
    enum ErrorRequest: Error {
        case failureToGetData
    }
    
    private enum HTTPMethod: String {
        case GET
        case POST
    }
    
    private func createRequest(url: String, type: HTTPMethod, completion: @escaping (URLRequest) -> Void){
        guard let urlToRequest = URL(string: url) else {return}
        
        var request = URLRequest(url: urlToRequest)
        
        request.httpMethod = type.rawValue
        
        completion(request)
    }
    
    public func getHome(completion: @escaping (Result<Response<Page>, Error>) -> Void){
        createRequest(url: "API", type: .GET) { url in
            
            let task = URLSession.shared.dataTask(with: url) { response, _, error in
                guard let data = response, error == nil else {
                    completion(.failure(ErrorRequest.failureToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(Response<Page>.self, from: data)
                    
                    completion(.success(result))
                } catch {
                    completion(.failure(ErrorRequest.failureToGetData))
                }
            }
            
            task.resume()
        }
        
    }
}
