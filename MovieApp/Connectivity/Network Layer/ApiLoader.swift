//
//  ApiLoader.swift
//  MovieApp
//
//  Created by Shashank on 04/04/21.
//

import Alamofire
import Foundation

class ApiLoader<T: NetworkRequestHandler> {
    let apiRequest: T
    
    init(apiRequest: T, urlSession: URLSession = .shared){
        self.apiRequest = apiRequest
    }
    
    func loadAPIRequest(requestData: T.RequestDataType, service: URL, urlString: String = "", method: Alamofire.HTTPMethod, headers: [String:Any]?, httpBody: [String:Any]?,
                        completionHandler: @escaping ([String: AnyObject]?, Error?) -> ()) {
        
      
        
        print("request \(urlString)")
        print("header \(headers)")
        print("parameters \(String(describing: httpBody))")
        
        AF.request(service, method: .get, parameters: requestData as? Parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            print(response.result)
            
            switch response.result {
                
            case .success(_):
                if let json = response.value {
                    completionHandler((json as! [String:AnyObject]), response.error)
                }
                break
            case .failure(let _):
                print(Error.self)
                completionHandler(nil, response.error)
                break
            }
        }
        
    }
}
