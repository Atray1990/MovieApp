//
//  Result.swift
//  MovieApp
//
//  Created by Shashank on 04/04/21.
//
import Foundation
public enum Results<Value, CAError> {
    
    case success(Value)
    case failure(CAError)
    
    var optionalValue:Value? {
        switch self {
        case .success(let value):
            return value
        default:
            return nil
        }
    }
}

