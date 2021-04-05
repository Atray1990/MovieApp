//
//  GetDataRequestHandler.swift
//  TestProjectData
//
//  Created by shashank atray on 13/10/20.
//  Copyright © 2020 shashank atray. All rights reserved.
//  LinkeIn - https://www.linkedin.com/in/shashank-k-atray/
//

import Foundation

public protocol GetDataRequestHandlerUseCase {
func requestForUserDataWith(requestUrl: URL, completionHandler:  @escaping (Results<TestPackage, CAError>)->())}

extension GetDataRequestHandlerUseCase {
    
    public func requestForUserDataWith(requestUrl: URL, completionHandler:  @escaping (Results<TestPackage, CAError>)->()) {
        
        ApiServiceCall.shared.call(param: nil, service: requestUrl, method: .get, urlString: requestUrl.absoluteString) { (response) in
            switch response{
            case .success(let data):
                do {
                    if let parsed = try? JSONDecoder().decode(TestPackage.self, from: data!) {
                       completionHandler(.success(parsed))
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

public struct GetDataRequestHandler: GetDataRequestHandlerUseCase {
    public init() {}
}
