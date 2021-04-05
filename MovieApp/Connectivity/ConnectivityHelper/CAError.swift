//
//  CAError.swift
//  MovieApp
//
//  Created by Shashank on 04/04/21.
//
import Foundation


public enum CAError: Error {
    case none
    case parsingFailure(message: String, request: String)
    case noData(message: String, request: String)
    case serverFailure(Error)
    case serverRefused(message: String)
    case other(childError: Error)
}

extension CAError: CustomStringConvertible {
    public var description : String {
        switch self {
        case .none:
            return "none"
        case .parsingFailure(let message, let request):
            return "could not parse json \(message) \(request)"
        case .noData(let message, let request):
            return "no data \(message) \(request)"
        case .serverFailure(let err):
            return "\(err.localizedDescription)"
        case .serverRefused(let message):
            return "api validation \(message)"
        case .other(let err):
            return "\(err.localizedDescription)"
        }
    }
    
    //Internal code 9 + HTML Response Code
    var code : NSNumber {
        switch self {
        case .none:
            return -1
        case .parsingFailure:
            return 9400 //bad request internal
        case .noData:
            return 9404 //Missing internal
        case .serverFailure(let err):
            return NSNumber(value: err._code)
        case .serverRefused:
            return 403  //Forbiden server
        case .other(let err):
            return NSNumber(value: err._code)
        }
    }
    var domain : String {
        switch self {
        case .none:
            return "com.anything.none"
        case .parsingFailure:
            return "com.anything.parsing"
        case .noData:
            return "com.anything.noData"
        case .serverFailure(let err):
            return err._domain
        case .serverRefused:
            return "com.anything.api.error"
        case .other(let err):
            return err._domain
        }
    }
}
