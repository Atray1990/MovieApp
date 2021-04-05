//
//  NetworkProtocol.swift
//  MovieApp
//
//  Created by Shashank on 04/04/21.
//

import Alamofire

protocol RequestHandler {
    associatedtype RequestDataType
    func makeRequest(from data: RequestDataType, service: URL, method: Alamofire.HTTPMethod, headers: [String:Any]?, httpBody: [String:Any]?)
}

typealias NetworkRequestHandler = RequestHandler

struct NetworkAPIHandler: NetworkRequestHandler {
    
    func makeRequest(from param: Parameters, service: URL, method: Alamofire.HTTPMethod, headers: [String:Any]?, httpBody: [String:Any]?) {
        
        AF.request(service, method: method, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            print(response.result)
        }
        
    }
    
    
    
}
