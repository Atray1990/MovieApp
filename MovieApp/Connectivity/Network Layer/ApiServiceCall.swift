//
//  ApiServiceCall.swift
//  MovieApp
//
//  Created by Shashank on 04/04/21.
//

import Alamofire
import Foundation

class ApiServiceCall {
    
    static let shared = ApiServiceCall()
    
    func call(param: [String: Any]? = nil, service: URL, method: Alamofire.HTTPMethod, urlString: String = "", headers: [String:Any]? = nil, httpBody: [String:Any]? = nil, completion: ((Results<Data?, CAError>)->())?) {
        let api = NetworkAPIHandler()
        let apiTaskLoader = ApiLoader(apiRequest: api)
        apiTaskLoader.loadAPIRequest(requestData: param ?? [:], service: service, urlString:urlString, method: method, headers: headers, httpBody: httpBody) { (response, error) in
            
            guard let response = response else {
                let error = CAError.noData(message: "Nil response object", request: urlString)
                print(error.localizedDescription)
                if let completion = completion {
                    completion(.failure(error))
                }

                return
            }
            
            do {
                switch ResponseValidator.validateResponse(json: response) {
                case .success(let jsonResponse):
                    if let completion = completion {
                        let jsonData = try JSONSerialization.data(withJSONObject: jsonResponse, options: JSONSerialization.WritingOptions.prettyPrinted)
                        print(jsonResponse)
                        completion(.success(jsonData))
                    }
                case .failure(let error):
                    if let completion = completion {
                        print(error.localizedDescription)
                        completion(.failure(error))
                    }
                }
                
            } catch let error {
                print(error)
            }
        }
    }
    
}
