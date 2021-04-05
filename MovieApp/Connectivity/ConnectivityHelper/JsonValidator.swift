//
//  JsonValidator.swift
//  MovieApp
//
//  Created by Shashank on 04/04/21.
//

import Foundation

struct ResponseValidator {
    
    static func validateResponse(json: [String:AnyObject]?) -> Result<[String:AnyObject], CAError> {
        
        guard let json = json else {
            return .failure(.noData(message: "missing json", request: ""))
        }
        
        if let error = json["error_message"] as? String {
            return .failure(.serverRefused(message: error))
        }
        
        if let errors = json["errors"] as? [[String:AnyObject]] {
            if let errMsg = errors.first?["message"] as? String {
                return .failure(.serverRefused(message: errMsg))
            }
        }
        
        if let error = json["errors"] as? [String:AnyObject] { // TODO: remove above ^ ?
            if let errMsg = error["message"] as? String {
                return .failure(.serverRefused(message: errMsg))
            }
        }
        
        if let success = json["success"] as? Bool, !success {
            return .failure(.serverRefused(message: "success is false"))
        }
        
        return .success(json)
    }
    
    
}
